//
//  Flag.swift
//  In Sight
//
//  Created by Kelly Maclauchlan on 2017-11-10.
//  Copyright © 2017 Kelly Maclauchlan. All rights reserved.
//

import Foundation
class Flag : Serializable {
    internal var jsonProperties = ["lat","longs","capturesLeft"];
    
    
    var lat = "EFGR"
    var longs = ""
    var capturesLeft = 5
    
    init(lat:String,longs:String,capturesLeft:Int) {
        self.lat=lat;
        self.longs=longs;
        self.capturesLeft=capturesLeft;
        
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
        if( key == "lat"){
            return self.lat as AnyObject!;
        }else if( key == "longs"){
            return self.longs as AnyObject!;
        }else if( key == "capturesLeft"){
            return self.capturesLeft as AnyObject!;
        }
        return "" as AnyObject!;
    }
    internal func setValueForKey(key: String!,value: String!)  {
        if( key == "lat"){
            return self.lat = value;
        }else if( key == "longs"){
            return self.longs = value
        }else if( key == "capturesLeft"){
            return self.capturesLeft = Int(value)!
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
