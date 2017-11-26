//
//  MainGameViewController.swift
//  In Sight
//
//  Created by Kelly Maclauchlan on 2017-09-11.
//  Copyright © 2017 Kelly Maclauchlan. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
class MainGameViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager:CLLocationManager!
    var currentLocation:CLLocation!
    var mapView:GMSMapView!
    var wentToUser:Bool = false;
    var game:Game!
    var server = ServerConnection()
    var flags:[CLLocationCoordinate2D]=[]
    var flagsCaptured:[Int]!
    var myIndex=0;
    var timer = Timer()
    var name = ""
    var captureFlagButton:UIButton!
    var capturePreyButton:UIButton!
    var flagToCaputure=0;
    var preyToCapture=0;
    
    override func loadView() {
        self.captureFlagButton = UIButton(frame: CGRect(x: 50, y: 400, width: 200, height: 50))
        captureFlagButton.backgroundColor = .red
        captureFlagButton.setTitle("Catch flag:", for: .normal)
        captureFlagButton.addTarget(self, action:#selector(self.CatchFlagClicked(_:)), for: .touchUpInside)
        captureFlagButton.isHidden=true;
        
//        self.view.addSubview(captureFlagButton)
        self.capturePreyButton = UIButton(frame: CGRect(x: 50, y: 400, width: 200, height: 50))
        capturePreyButton.backgroundColor = .red
        capturePreyButton.setTitle("Catch Prey:", for: .normal)
        capturePreyButton.addTarget(self, action:#selector(self.CatchPreyClicked(_:)), for: .touchUpInside)
        capturePreyButton.isHidden=true;
        
        
        game = server.start()
        for i in 0...game.players.count{
            if(game.players[i].name==self.name){
                self.myIndex=i;
            }
        }
        var playerUpdateTimer = Timer.scheduledTimer(timeInterval: 20.0, target: self, selector: #selector(MainGameViewController.updatePlayer), userInfo: nil, repeats: true)
        
        var gameOverTimer = Timer.scheduledTimer(timeInterval: TimeInterval(game.timeLimit*60), target: self, selector: #selector(MainGameViewController.endGame), userInfo: nil, repeats: true)
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        
        determineMyCurrentLocation()
        
//        let camera = GMSCameraPosition.camera(withLatitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, zoom: 6.0)
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        view = mapView
        
        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
        
        //game boundaries defined
        let path = GMSMutablePath()
        for i in 0...game.lats.count{
            path.add(CLLocationCoordinate2D(latitude: Double(game.lats[i])!, longitude: Double(game.longs[i])!))
        }
        //putting the flag coordonates as real points
        var points:[CLLocationCoordinate2D] = []
        for i in 0...game.flags.count{
            let coord = CLLocationCoordinate2D(latitude: Double(game.flags[i].lat)!, longitude: Double(game.flags[i].longs)!)
            points.append(coord)
            let marker = GMSMarker()
                    marker.position = coord
                    marker.title = "Flag"
                    marker.map = mapView
        }
        self.flags=points;
        
        self.view.addSubview(captureFlagButton)
        self.view.addSubview(capturePreyButton)
//        let path = GMSMutablePath()
//        path.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0))
//        path.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.0))
//        path.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.2))
//        path.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.2))
//        path.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0))
//
        
        let rectangle = GMSPolyline(path: path)
        rectangle.map = mapView
    }
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
//        user latitude = 45.4482861422426
//        user longitude = -75.5914605875272
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        currentLocation=userLocation;
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
//        mapView.myLocation=userLocation;
        if let mylocation = mapView.myLocation {
            print("User's location: \(mylocation)")
            if(!wentToUser){
                let camera = GMSCameraPosition.camera(withLatitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, zoom: 6.0)
                wentToUser=true;
                mapView.animate(to: camera);
            }
        } else {
            print("User's location is unknown")
        }
        
        // if player is a hunter then check the distances between you and other players if you are within a meter then allow for capture button to be visible
        if(game.players[myIndex].hunter){
            self.capturePreyButton.isHidden=true;
            for i in 0...game.players.count{
                var player = game.players[i];
                var index=player.lats.count-1
                var coord=CLLocation(latitude: Double(player.lats[index])!, longitude: Double(player.longs[index])!)
                if(userLocation.distance(from: coord)<2){
                    if(!player.hunter){
                        self.capturePreyButton.isHidden=false;
                        self.preyToCapture=i;
                        //user can capture the flag they are close enough and have not caught it before
                       
                    }
                }
            }
        }else{
            self.captureFlagButton.isHidden=true;
            for i in 0...flags.count{
                
                var coord=CLLocation(latitude: flags[i].latitude, longitude: flags[i].longitude)
                if(userLocation.distance(from: coord)<2){
                    if(!self.flagsCaptured.contains(i)){
                        //user can capture the flag they are close enough and have not caught it before
                        
                        self.captureFlagButton.isHidden=false;
                        self.flagToCaputure=i
                    }
                }
            }
        }
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("in outer segue")
        if (segue.identifier == "ToScore") {
            
            var svc = segue.destination as! ScoreViewController;
            
            svc.game = game;
            print("in segue")
        }
    }
    
    
    func updatePlayer(){
        let update = PlayerUpdate(playerIndex: myIndex, lats: currentLocation.coordinate.latitude.description, longs: currentLocation.coordinate.longitude.description)
        game=server.update(update: update)
        print("update sent to server");
    }
    
    func endGame(){
        game=server.gameOverEnd();
        print("the game is over. time ran out")
        //add game over button to the screen
        let EndGameButton = UIButton(frame: CGRect(x: 50, y: 400, width: 200, height: 50))
        EndGameButton.backgroundColor = .blue
        EndGameButton.setTitle("See Final Scores:", for: .normal)
        EndGameButton.addTarget(self, action:#selector(self.ContinueClicked(_:)), for: .touchUpInside)
        
        self.view.addSubview(EndGameButton)
    }
    @IBAction func ContinueClicked(_ sender: Any) {
        //trigger segue to next screen
        performSegue(withIdentifier: "ToScore", sender: nil)
    }
    @IBAction func CatchPreyClicked(_ sender: Any) {
        let update = CatchUpdate(hunterIndex: myIndex, caughtIndex: self.preyToCapture)
        game=server.capturePlayer(update: update)
    }
    @IBAction func CatchFlagClicked(_ sender: Any) {
        let update = FlagUpdate(nameIndex: self.myIndex, flagIndex: self.flagToCaputure)
        game=server.collectFlag(update: update)
        self.flagsCaptured.append(flagToCaputure);
    }
    
}
