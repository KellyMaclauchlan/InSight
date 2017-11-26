//
//  CatchUpdate.swift
//  In Sight
//
//  Created by Kelly Maclauchlan on 2017-11-12.
//  Copyright © 2017 Kelly Maclauchlan. All rights reserved.
//

import Foundation
class CatchUpdate : Serializable {
    internal var jsonProperties = ["caughtIndex","hunterIndex"];
    
    var hunterIndex = 0;
    var caughtIndex = 0 ;
    
    init(hunterIndex:Int,caughtIndex:Int) {
        self.hunterIndex=hunterIndex;
        self.caughtIndex=caughtIndex;
        
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
        if( key == "hunterIndex"){
            return self.hunterIndex as AnyObject!;
        }else if( key == "caughtIndex"){
            return self.caughtIndex as AnyObject!;
        }
        return "" as AnyObject!;
    }
    internal func setValueForKey(key: String!,value: String!)  {
        if( key == "hunterIndex"){
            return self.hunterIndex = Int(value)!
        }else if( key == "caughtIndex"){
            return self.caughtIndex = Int(value)!
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
