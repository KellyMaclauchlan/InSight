//
//  In_SightTests.swift
//  In SightTests
//
//  Created by Kelly Maclauchlan on 2017-09-09.
//  Copyright © 2017 Kelly Maclauchlan. All rights reserved.
//

import XCTest
@testable import In_Sight
extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
class In_SightTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
   
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let responseString = "{\"players\":[{\"hunter\":false,\"name\":\"kelly\",\"score\":0,\"lats\":[],\"longs\":[]}],\"numberOfPlayers\":2,\"numberOfHunters\":1,\"flags\":[{\"lat\":\"45.6176873886061\",\"longs\":\"-74.0205322578549\",\"capturesLeft\":1},{\"lat\":\"44.1228877786246\",\"longs\":\"-74.4050537422299\",\"capturesLeft\":1},{\"lat\":\"45.6407355724571\",\"longs\":\"-77.5031986087561\",\"capturesLeft\":1}],\"lats\":[\"46.4263097474902\",\"46.3050113633105\",\"43.0967711568643\",\"44.8284092862188\",\"-180.0\"],\"longs\":[\"-77.9536380618811\",\"-73.0537353828549\",\"-73.9875732734799\",\"-78.2942142337561\",\"-180.0\"],\"gameCode\":\"ktxs\",\"timeLimit\":5}"
//            JSONSerialization.jsonObject(with: <#T##InputStream#>, options: <#T##JSONSerialization.ReadingOptions#>)
//            var json=try? JSONSerialization.jsonObject(with: responseString as Any], options: [])
        //var data = responseString.toJSON()
        var data: Data = responseString.data(using: String.Encoding.utf8)!
        do {
            let anyObj: AnyObject? = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as AnyObject
        //let parsedData = try JSONSerialization.jsonObject(with: json!) as! [String:Any]
            var game = Game(any: anyObj!)
            print("in test")
        } catch  {
            print("something went wrong")
            
        }
        
        //        Optional(<__NSSingleObjectArrayI 0x174009cc0>(
        //            {
        //                hunter = 0;
        //                lats =     (
        //                );
        //                longs =     (
        //                );
        //                name = kelly;
        //                score = 0;
        //            }
        //        )
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
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
