//
//  AddBoundariesViewController.swift
//  In Sight
//
//  Created by Kelly Maclauchlan on 2017-09-15.
//  Copyright © 2017 Kelly Maclauchlan. All rights reserved.
//

import UIKit
import GoogleMaps
extension ViewController: GMSMapViewDelegate {
   
}
class AddBoundariesViewController: UIViewController,GMSMapViewDelegate, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager!
    var currentLocation:CLLocation!
    var mapView:GMSMapView!
    var wentToUser:Bool = false;
    var path:GMSMutablePath!
    var rectangle:GMSPolygon!
    var numFlag=5;
    var flags:[CLLocationCoordinate2D]!
    var code="sdkf"
    var game:GameSettings!
    var chosingFlags=false;
    
   
    @IBAction func ContinueClicked(_ sender: Any) {
        //send info to server and go to next screen send game code over in segue
        var lats:[String]=[]
        var longs:[String]=[]
        var flagLats:[String]=[]
        var flagLongs:[String]=[]
        for i in 0...path.count(){
            let coord=path.coordinate(at: i)
            lats.append(coord.latitude.description)
            longs.append(coord.longitude.description)
        }
        for i in 0...flags.count-1{
            let coord=flags[i]
            flagLats.append(coord.latitude.description)
            flagLongs.append(coord.longitude.description)
        }
        game.longs=longs;
        game.lats=lats;
        game.flagLats=flagLats;
        game.flagLongs=flagLongs;
        //server send and connect
        let server = ServerConnection();
        let realGame = server.create(gameSettings: game);
        self.code=realGame.gameCode;
        
        performSegue(withIdentifier: "ToWaitForStart", sender: nil)
    }
    @IBAction func CreateBoundariesClicked(_ sender: UIButton) {
        rectangle = GMSPolygon(path: self.path)
        rectangle.strokeWidth = 5
        rectangle.strokeColor = .black
        
        
        rectangle.map = mapView
        //set the flags within the boundaries
//        setupFlags()
        self.chosingFlags=true
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        label.text = "Add "+game.numberFlags.description+" flags "
        self.view.addSubview(label)

    }
 
    override func loadView() {
        determineMyCurrentLocation()
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        view = mapView
        flags=[]
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        path = GMSMutablePath()
        
        let button:UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 50))
        button.backgroundColor = .black
        button.setTitle("Button", for: .normal)
        button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        
        let CreateBoundariesButton = UIButton(frame: CGRect(x: 50, y: 50, width: 200, height: 50))
        CreateBoundariesButton.backgroundColor = .black
        CreateBoundariesButton.setTitle("Draw Boundaries", for: .normal)
        CreateBoundariesButton.addTarget(self, action:#selector(self.CreateBoundariesClicked(_:)), for: .touchUpInside)
        

        self.view.addSubview(CreateBoundariesButton)
        //self.view.addSubview(GoBackButton)
    }
    func buttonClicked() {
        print("Button Clicked")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        // Custom logic here
        if(self.chosingFlags){
            if(flags.count<game.numberFlags){
                flags.append(coordinate)
                let marker = GMSMarker()
                marker.position = coordinate
                marker.title = "new flag"
                marker.snippet = ""
                marker.map = mapView
                marker.icon = GMSMarker.markerImage(with: .black)
                if(flags.count==game.numberFlags){
                    let CreateBoundariesButton = UIButton(frame: CGRect(x: 50, y: 400, width: 200, height: 50))
                    CreateBoundariesButton.backgroundColor = .red
                    CreateBoundariesButton.setTitle("Create Game", for: .normal)
                    CreateBoundariesButton.addTarget(self, action:#selector(self.ContinueClicked(_:)), for: .touchUpInside)
                    self.view.addSubview(CreateBoundariesButton)

                }
            }
        }else{
            let marker = GMSMarker()
            marker.position = coordinate
            marker.title = "I added this with a long tap"
            marker.snippet = ""
            marker.map = mapView
            self.path.add(coordinate);
        }
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
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    func setupFlags(){
        //get upper and lowerbounds of possible latitude sand longetudes within boundaries
        var biggestLat=path.coordinate(at: 0).latitude
        var biggestLong=path.coordinate(at: 0).longitude
        var smallestLat=path.coordinate(at: 0).latitude
        var smallestLong=path.coordinate(at: 0).longitude
        
        for i in 0...path.count(){
            let coord=path.coordinate(at: i)
            if(coord.latitude>biggestLat){
                biggestLat = coord.latitude
            }
            if(coord.latitude<smallestLat){
                smallestLat = coord.latitude
            }
            if(coord.longitude>biggestLong){
                biggestLong = coord.longitude
            }
            if(coord.longitude<smallestLong){
                smallestLong = coord.longitude
            }
        }
        var currentFlags=0
        while currentFlags<numFlag{
           let lat = smallestLat + Double(arc4random_uniform(UInt32(biggestLat - smallestLat)))+drand48()
           let long = smallestLong + Double(arc4random_uniform(UInt32(biggestLong - smallestLong)))+drand48()
        
        let possiblePoint = CLLocationCoordinate2D(latitude: lat, longitude: long);
        
            if GMSGeometryContainsLocation(possiblePoint, self.path, true) {
                print("YES: you are in this polygon.")
                currentFlags+=1;
                flags.append(possiblePoint)
//                let marker = GMSMarker()
//                marker.position = possiblePoint
//                marker.title = "Flag #"+String(currentFlags)
//                marker.map = mapView
            } else {
                print("You do not appear to be in this polygon.")
            }
        }
        print("set all flags")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("in outer segue")
        if (segue.identifier == "ToWaitForStart") {
            var svc = segue.destination as! WaitForPlayersViewController;
            
            svc.code = code;
            print("in segue")
        }
    }
    
    
    
}
