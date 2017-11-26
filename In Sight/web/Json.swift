//
//  Json.swift
//  Bonfire
//
//  Created by Kelly Maclauchlan on 2016-11-27.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//  
/* from git repo:
 Purpose:
 Convert (or Serialize) an object to a JSON String or Dictionary.
 Usage:
 Use 'Serialize.toJSON' on instances of classes that:
 - Inherit from NSObject
 - Implement 'Serializable' protocol
 - Implement the property 'jsonProperties' and return an array of strings with names of all the properties to be serialized
 Inspiration/Alternative:
 https://gist.github.com/turowicz/e7746a9c035356f9483d
 */

import Foundation
@objc protocol Serializable {
    var jsonProperties:Array<String> { get }
    func valueForKey(key: String!) -> AnyObject!
}

struct Serialize {
    static func toDictionary(obj:Serializable) -> NSDictionary {
        // make dictionary
        var dict = Dictionary<String, AnyObject>()
        
        // add values
        for prop in obj.jsonProperties {
            var val:AnyObject! = obj.valueForKey(key: prop)
            dict[prop] = val
            
        }
        
        // return dict
        return dict as NSDictionary
    }
    
    public static func toJSON(obj:Serializable) -> String {
        // get dict
        var dict = toDictionary(obj: obj)
        
        // make JSON
        var error:NSError?
        do{
            var data = try JSONSerialization.data(withJSONObject: dict, options:.prettyPrinted)
            // return result
            return NSString(data: data, encoding: String.Encoding.utf8.rawValue) as! String
        }
        catch{
            
        }
        return "";
    }
}
