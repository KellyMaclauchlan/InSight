//
//  Player.swift
//  In Sight
//
//  Created by Kelly Maclauchlan on 2017-11-10.
//  Copyright © 2017 Kelly Maclauchlan. All rights reserved.
//

import Foundation
class Player : Serializable {
    internal var jsonProperties = ["score","name","hunter","lats","longs"];
    
    
    var score = 5
    var name = ""
    var hunter = false
    var lats:[String] = []
    var longs:[String] = []
    
    
    
    init(score:Int,name:String,hunter:Bool,lats:[String],longs:[String]) {
        self.score = score;
        self.name = name;
        self.hunter = hunter;
        self.lats=lats;
        self.longs=longs;
    }
    init(){
        self.lats=[];
        self.longs=[];
        
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
        if( key == "score"){
            return self.score as AnyObject!;
        }else if( key == "name"){
            return self.name as AnyObject!;
        }else if( key == "hunter"){
            return self.hunter as AnyObject!;
        }else if( key == "longs"){
            return self.longs as AnyObject!;
        }else if( key == "lats"){
            return self.lats as AnyObject!;
        }
        return "" as AnyObject!;
    }
    internal func setValueForKey(key: String!,value: String!)  {
        if( key == "score"){
            return self.score = Int(value)!;
        }else if( key == "name"){
            return self.name = value
        }else if( key == "hunter"){
            return self.hunter = Bool(value)!
        }else if( key == "longs"){
            return self.longs = toArrayOfStrings(string: value!)!
        }else if( key == "lats"){
            return self.lats = toArrayOfStrings(string: value!)!
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
