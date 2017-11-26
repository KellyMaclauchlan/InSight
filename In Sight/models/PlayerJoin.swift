//
//  PlayerJoin.swift
//  In Sight
//
//  Created by Kelly Maclauchlan on 2017-09-24.
//  Copyright © 2017 Kelly Maclauchlan. All rights reserved.
//

import Foundation
import UIKit
class PlayerJoin : Serializable {
    internal var jsonProperties = ["gameCode","name","hunter"];
    
    
    var gameCode = "EFGR";
    var name = "";
    var hunter = 0 //bool 0=false 1=true
    
    init(gameCode:String,name:String,hunter:Int) {
        self.gameCode=gameCode;
        self.name=name;
        self.hunter=hunter;
        
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
        if( key == "gameCode"){
            return self.gameCode as AnyObject!;
        }else if( key == "name"){
            return self.name as AnyObject!;
        }else if( key == "hunter"){
            return self.hunter as AnyObject!;
        }
        return "" as AnyObject!;
    }
    internal func setValueForKey(key: String!,value: String!)  {
        if( key == "gameCode"){
            return self.gameCode = value;
        }else if( key == "name"){
            return self.name = value
        }else if( key == "hunter"){
            return self.hunter = Int(value)!
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
