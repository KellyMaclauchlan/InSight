//
//  GameSettings.swift
//  In Sight
//
//  Created by Kelly Maclauchlan on 2017-09-24.
//  Copyright © 2017 Kelly Maclauchlan. All rights reserved.
//

import Foundation
import UIKit
class GameSettings : Serializable {
    internal var jsonProperties = ["numberPlayers","timeLimit","numberFlags","numberHunters","name","hunter","lats","longs","flagLats","flagLongs","chooseHunter"];
    
    
    var numberPlayers = 2;
    var timeLimit = 30; //in minutes
    var numberFlags = 0;
    var numberHunters = 1;
    var lats:[String]=[]
    var longs:[String]=[]
    var flagLats:[String]=[]
    var flagLongs:[String]=[]
    var name = "";
    var hunter = false
    var chooseHunter = true
    
    init(numPlayers:Int, timeLim:Int, numFlags:Int,numHunters:Int,lats:[String],name:String,hunter:Bool,pick:Bool, longs:[String],flagLats:[String],flagLongs:[String]) {
        self.numberPlayers=numPlayers;
        self.timeLimit = timeLim;
        self.numberFlags=numFlags;
        self.numberHunters=numHunters;
        self.lats=lats;
        self.longs=longs;
        self.flagLats=flagLats;
        self.flagLongs=flagLongs;
        self.name=name;
        self.hunter=hunter;
        self.chooseHunter=pick;
        
    }
    init(){
        
    }
    init(JSONString: String) {
        
        do {
            let jsonDict = convertStringToDictionary(text: JSONString);
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDict, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            // here "decoded" is of type `Any`, decoded from JSON data
            
            // you can now cast it with the right type
            if let dictFromJSON = decoded as? [String:String] {
                for(key,value) in dictFromJSON{
                    let keyName = key as String
                    let keyValue = value as String;
                    
                    setValueForKey(key: keyName, value: keyValue);
                    
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
    internal func valueForKey(key: String!) -> AnyObject! {
         if( key == "numberPlayers"){
            return self.numberPlayers as AnyObject!;
        }else if( key == "timeLimit"){
            return self.timeLimit as AnyObject!;
        }else if( key == "numberFlags"){
            return self.numberFlags as AnyObject!;
        }else if( key == "numberHunters"){
            return self.numberHunters as AnyObject!;
        }else if( key == "name"){
            return self.name as AnyObject!;
        }else if( key == "hunter"){
            return self.hunter as AnyObject!;
        }else if( key == "chooseHunter"){
            return self.chooseHunter as AnyObject!;
         }else if( key == "lats"){
            return self.lats as AnyObject!;
         }else if( key == "longs"){
            return self.longs as AnyObject!;
         }else if( key == "flagLats"){
            return self.flagLats as AnyObject!;
         }else if( key == "flagLongs"){
            return self.flagLongs as AnyObject!;
        }
        return "" as AnyObject!;
    }
    
    internal func setValueForKey(key: String!,value: String!)  {
         if( key == "numberPlayers"){
            return self.numberPlayers = Int(value)!
        }else if( key == "timeLimit"){
            return self.timeLimit = Int(value)!
        }else if( key == "numberFlags"){
            return self.numberFlags = Int(value)!
        }else if( key == "numberHunters"){
            return self.numberHunters = Int(value)!
        }else if( key == "name"){
            return self.name = value
        }else if( key == "hunter"){
            return self.hunter = Bool(value)!
        }else if( key == "chooseHunter"){
            return self.chooseHunter = Bool(value)!
         }else if( key == "lats"){
            return self.lats = toArrayOfStrings(string: value!)!
         }else if( key == "longs"){
            return self.longs = toArrayOfStrings(string: value!)!
         }else if( key == "flagLats"){
            return self.flagLats = toArrayOfStrings(string: value!)!
         }else if( key == "flagLongs"){
            return self.flagLongs = toArrayOfStrings(string: value!)!
        }
        
    }
    
    
    func toArrayOfStrings(string:String)->[String]?{
        let results = string
            .trimmingCharacters(in:NSCharacterSet(charactersIn: "[]") as CharacterSet)
            .components(separatedBy: ",")
        print(results);
        return results
    }
    
    public func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
}
