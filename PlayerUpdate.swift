//
//  PlayerUpdate.swift
//  In Sight
//
//  Created by Kelly Maclauchlan on 2017-11-12.
//  Copyright © 2017 Kelly Maclauchlan. All rights reserved.
//

import Foundation
class PlayerUpdate : Serializable {
    internal var jsonProperties = ["playerIndex","lats","longs"];
    
    var playerIndex = 0;
    var lats = "" ;
    var longs = "" ;
    
    init(playerIndex:Int,lats:String,longs:String) {
        self.playerIndex=playerIndex;
        self.lats=lats;
        self.longs=longs;
        
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
        if( key == "playerIndex"){
            return self.playerIndex as AnyObject!;
        }else if( key == "lats"){
            return self.lats as AnyObject!;
        }else if( key == "longs"){
            return self.longs as AnyObject!;
        }
        return "" as AnyObject!;
    }
    internal func setValueForKey(key: String!,value: String!)  {
        if( key == "playerIndex"){
            return self.playerIndex = Int(value)!
        }else if( key == "lats"){
            return self.lats = value
        }else if( key == "longs"){
            return self.longs = value
        }
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
