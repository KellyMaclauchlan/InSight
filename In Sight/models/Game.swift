//
//  Game.swift
//  In Sight
//
//  Created by Kelly Maclauchlan on 2017-11-10.
//  Copyright © 2017 Kelly Maclauchlan. All rights reserved.
//


import Gloss
class Game : Glossy {
    func toJSON() -> JSON? {
        return nil;
    }
    
    internal var jsonProperties = ["players","timeLimit","flags","numberPlayers","numberHunters","lats","longs","gameCode"];
    
    
    var numberPlayers = 2;
    var timeLimit = 30; //in minutes
    var flags:[Flag]!
    var numberHunters = 1;
    var lats:[String]!
    var longs:[String]!
    var players:[Player]!
    var gameCode="wert"
    
    required init?(json:JSON){
        self.numberPlayers=("numberOfPlayers"<~~json)!
        self.timeLimit = ("timeLimit"<~~json)!
        self.numberHunters=("numberOfHunters"<~~json)!
        self.gameCode=(gameCode<~~json)!
//        let people:[Player] = []
        if let peopleJson:[JSON] = "players"<~~json,
            let people = [Player].from(jsonArray:peopleJson){
                self.players=people;
        }
//        self.flags=flags
//        self.players=players
//        self.lats=lats
//        self.longs=longs
    }
    init(any:AnyObject){
        let json = any as! JSON
        self.numberPlayers=("numberOfPlayers"<~~json)!
        self.timeLimit = ("timeLimit"<~~json)!
        self.numberHunters=("numberOfHunters"<~~json)!
        self.gameCode=("gameCode"<~~json)!
        //        let people:[Player] = []
        if let peopleJson:[JSON] = "players"<~~json,
            let people = [Player].from(jsonArray:peopleJson){
            self.players=people;
        }
    }
//    init(numPlayers:Int, timeLim:Int,numHunters:Int,players:[Player],flags:[Flag],lats:[String],longs:[String],gameCode:String) {
//        self.numberPlayers=numPlayers;
//        self.timeLimit = timeLim;
//        self.numberHunters=numHunters;
//        self.players=players
//        self.lats=lats
//        self.longs=longs
//        self.gameCode=gameCode
//        self.flags=flags
//
//
//    }
    init(){

    }
//    init(JSONString: String) {
//
//        do {
//            let jsonDict = convertStringToDictionary(text: JSONString);
//            let jsonData = try JSONSerialization.data(withJSONObject: jsonDict, options: .prettyPrinted)
//            // here "jsonData" is the dictionary encoded in JSON data
//
//            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
//            // here "decoded" is of type `Any`, decoded from JSON data
//            print(jsonDict!["players"])
//            var playersArray = jsonDict!["players"]
//            print(playersArray?.description)
//
//            // you can now cast it with the right type
//            if let dictFromJSON = decoded as? [String:Any] {
//                for(key,value) in dictFromJSON{
//                    let keyName = key as String
//                    let keyValue = value as Any;
//
//                    setValueForKey(key: keyName, value: keyValue);
//
//                }
//
//            }
//
//        } catch {
//            print(error.localizedDescription)
//        }
//
//    }
//    internal func valueForKey(key: String!) -> AnyObject! {
//        if(key == "flags"){
//            return self.flags as AnyObject!;
//        }else if( key == "numberPlayers"){
//            return self.numberPlayers as AnyObject!;
//        }else if( key == "timeLimit"){
//            return self.timeLimit as AnyObject!;
//        }else if( key == "lats"){
//            return self.lats as AnyObject!;
//        }else if( key == "numberHunters"){
//            return self.numberHunters as AnyObject!;
//        }else if( key == "longs"){
//            return self.longs as AnyObject!;
//        }else if( key == "gameCode"){
//            return self.gameCode as AnyObject!;
//        }else if( key == "players"){
//            return self.players as AnyObject!;
//        }
//        return "" as AnyObject!;
//    }
//    internal func setValueForKey(key: String!,value: Any!)  {
//        var i=5
//        print(key)
//        if(key == "flags"){
//            return self.flags = flagArrayFromString(string: value as! String)
//        }else if( key == "numberPlayers"){
//            return self.numberPlayers = Int(value as! String)!
//        }else if( key == "timeLimit"){
//            return self.timeLimit = Int(value as! String)!
//        }else if( key == "lats"){
//            return self.lats = toArrayOfStrings(string: value! as! String)!
//        }else if( key == "numberHunters"){
//            return self.numberHunters = Int(value as! String)!
//        }else if( key == "longs"){
//            return self.longs = toArrayOfStrings(string: value! as! String)!
//        }else if( key == "gameCode"){
//            return self.gameCode = value as! String
////        }else if( key == "players"){
////
////            print(value)
////            print(String(describing:value))
////            return self.players = playerArrayFromString(string: String(describing:value))
//        }
//
//    }
//    func toArrayOfStrings(string:String)->[String]?{
//        let results = string
//            .trimmingCharacters(in:NSCharacterSet(charactersIn: "[]") as CharacterSet)
//            .components(separatedBy: ",")
//        print(results);
//        return results
//    }
//
//    public func convertStringToDictionary(text: String) -> [String:AnyObject]? {
//        if let data = text.data(using: String.Encoding.utf8) {
//            do {
//                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
//            } catch let error as NSError {
//                print(error)
//            }
//        }
//        return nil
//    }
//    func playerArrayFromString(string:String)->[Player]{
//        if(string == "[]"){
//            return [];
//        }
//        if(string == ""){
//            return [];
//        }
//        let fullArr : [String] = string.components(separatedBy: "{")
//        var list = [Player]();
//
//        for two in (1..<fullArr.count){
//            var one = fullArr[two]
//            one.remove(at: one.index(before: one.endIndex ))
//            one.remove(at: one.index(before: one.endIndex ))
//            one="{"+one+"}"
//            list.append(Player(JSONString: one))
//
//
//        }
//        return list;
//    }
//
//    func flagArrayFromString(string:String)->[Flag]{
//        if(string == "[]"){
//            return [];
//        }
//        if(string == ""){
//            return [];
//        }
//        let fullArr : [String] = string.components(separatedBy: "{")
//        var list = [Flag]();
//
//        for two in (1..<fullArr.count){
//            var one = fullArr[two]
//            one.remove(at: one.index(before: one.endIndex ))
//            one.remove(at: one.index(before: one.endIndex ))
//            one="{"+one+"}"
//            list.append(Flag(JSONString: one))
//        }
//        return list;
//    }
    
}
