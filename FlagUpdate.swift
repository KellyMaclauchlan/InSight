//
//  FlagUpdate.swift
//  In Sight
//
//  Created by Kelly Maclauchlan on 2017-11-12.
//  Copyright © 2017 Kelly Maclauchlan. All rights reserved.
//

import Foundation
class FlagUpdate : Serializable {
    internal var jsonProperties = ["flagIndex","nameIndex"];
    
    var nameIndex = 0;
    var flagIndex = 0 ;
    
    init(nameIndex:Int,flagIndex:Int) {
        self.nameIndex=nameIndex;
        self.flagIndex=flagIndex;
        
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
        if( key == "nameIndex"){
            return self.nameIndex as AnyObject!;
        }else if( key == "flagIndex"){
            return self.flagIndex as AnyObject!;
        }
        return "" as AnyObject!;
    }
    internal func setValueForKey(key: String!,value: String!)  {
        if( key == "nameIndex"){
            return self.nameIndex = Int(value)!
        }else if( key == "flagIndex"){
            return self.flagIndex = Int(value)!
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
