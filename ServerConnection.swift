//
//  ServerConnection.swift
//  In Sight
//
//  Created by Kelly Maclauchlan on 2017-11-12.
//  Copyright © 2017 Kelly Maclauchlan. All rights reserved.
//

import Foundation
class ServerConnection{
    var baseurl = "http://"
    var ip = "192.168.1.5"   //"192.168.1.6"
    var port = ":8080/inSight/"
    var endpointGame = "game/"
    var makeGame = "makegame?"
    var joinGame = "joingame?"
    var startGame = "startGame?"
    var collectFlag = "collectFlag?"
    var capturePlayer = "capturePlayer?"
    var update = "update?"
    var gameOver = "gameOver?"
    
    
    
    init(){
    }
    
    func create(gameSettings:GameSettings)->Game{
        let semaphore = DispatchSemaphore(value: 0);
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointGame
        url=url+makeGame;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+self.gameSettingsToJson(gameSettings: gameSettings)
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        var game=Game()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response) )")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            print("responseString = \(String(describing: responseString))")
            game = self.gameFromJson(json: responseString!);
            
            print("responseString = \(String(describing: responseString))")
            semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        
        return game;
    }
    func join(playerJoin:PlayerJoin)->Game{
        let semaphore = DispatchSemaphore(value: 0);
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointGame
        url=url+joinGame;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+self.playerJoinToJson(playerJoin: playerJoin)
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        var game=Game()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response) )")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            print("responseString = \(String(describing: responseString))")
            game = self.gameFromJson(json: responseString!);
            
            print("responseString = \(String(describing: responseString))")
            semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        
        return game;
    }
    
    func start()->Game{
        let semaphore = DispatchSemaphore(value: 0);
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointGame
        url=url+startGame;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        var game=Game()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response) )")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            print("responseString = \(String(describing: responseString))")
            game = self.gameFromJson(json: responseString!);
            
            print("responseString = \(String(describing: responseString))")
            semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        
        return game;
    }
    
    func collectFlag(update:FlagUpdate)->Game{
        let semaphore = DispatchSemaphore(value: 0);
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointGame
        url=url+collectFlag;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+self.flagUpdateToJson(flagUpdate: update)
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        var game=Game()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response) )")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            print("responseString = \(String(describing: responseString))")
            game = self.gameFromJson(json: responseString!);
            
            print("responseString = \(String(describing: responseString))")
            semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        
        return game;
    }
    
    func capturePlayer(update:CatchUpdate)->Game{
        let semaphore = DispatchSemaphore(value: 0);
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointGame
        url=url+capturePlayer;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+self.catchUpdateToJson(catchUpdate: update)
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        var game=Game()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response) )")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            print("responseString = \(String(describing: responseString))")
            game = self.gameFromJson(json: responseString!);
            
            print("responseString = \(String(describing: responseString))")
            semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        
        return game;
    }
    func update(update:PlayerUpdate)->Game{
        let semaphore = DispatchSemaphore(value: 0);
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointGame
        url=url+self.update;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="+self.playerUpdateToJson(playerUpdate: update)
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        var game=Game()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response) )")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            print("responseString = \(String(describing: responseString))")
            game = self.gameFromJson(json: responseString!);
            
            print("responseString = \(String(describing: responseString))")
            semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        
        return game;
    }
    
    func gameOverEnd()->Game{
        let semaphore = DispatchSemaphore(value: 0);
        var url = self.baseurl+self.ip;
        url = url+self.port+self.endpointGame
        url=url+gameOver;
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = "input="
        print(postString);
        request.httpBody = postString.data(using: .utf8)
        var game=Game()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response) )")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            print("responseString = \(String(describing: responseString))")
            game = self.gameFromJson(json: responseString!);
            
            print("responseString = \(String(describing: responseString))")
            semaphore.signal();
        }
        task.resume()
        semaphore.wait(timeout: .distantFuture);
        
        return game;
    }
    
    //convert objects to and from json
    func gameToJson(game: Game)->String{
        return Serialize.toJSON(obj: game);
    }
    func gameFromJson(json: String)->Game{
        return Game(JSONString: json)
    }
    
    func gameSettingsToJson(gameSettings: GameSettings)->String{
        return Serialize.toJSON(obj: gameSettings);
    }
    func gameSettingsFromJson(json: String)->GameSettings{
        return GameSettings(JSONString: json)
    }
    
    func playerJoinToJson(playerJoin: PlayerJoin)->String{
        return Serialize.toJSON(obj: playerJoin);
    }
    func playerJoinFromJson(json: String)->PlayerJoin{
        return PlayerJoin(JSONString: json)
    }
    
    func playerUpdateToJson(playerUpdate: PlayerUpdate)->String{
        return Serialize.toJSON(obj: playerUpdate);
    }
    func playerUpdateFromJson(json: String)->PlayerUpdate{
        return PlayerUpdate(JSONString: json)
    }
    
    func flagUpdateToJson(flagUpdate: FlagUpdate)->String{
        return Serialize.toJSON(obj: flagUpdate);
    }
    func flagUpdateFromJson(json: String)->FlagUpdate{
        return FlagUpdate(JSONString: json)
    }
    
    func catchUpdateToJson(catchUpdate: CatchUpdate)->String{
        return Serialize.toJSON(obj: catchUpdate);
    }
    func catchUpdateFromJson(json: String)->CatchUpdate{
        return CatchUpdate(JSONString: json)
    }
}
