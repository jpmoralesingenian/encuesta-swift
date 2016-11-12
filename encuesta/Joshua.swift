//
//  Joshua.swift
//  encuesta
//
//  Created by Juan Pablo Morales on 11/12/16.
//  Copyright © 2016 Joshua Cafe Bar. All rights reserved.
//

import Foundation
/**
 This class handles all info from the API
 */
class Joshua {
    let baseUrl: String
    var locations = [NSDictionary]()
    var endFunction: Void->Void
    
    init() {
        self.baseUrl = "http://api.joshuacafebar.com/api/"
        self.endFunction = { Void-> Void in }
    }
    /**
     Load the locations if they are no there
     */
    func loadLocations(endFunction: Void->Void) {
        self.endFunction = endFunction
        if locations.count > 0 {
            // We already have locations loaded.
            return
        }
        let url = NSURL(string: self.baseUrl  + "locations")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) {
            (data, response, error) -> Void in
            
            if data!.length > 0 && error == nil{
                self.loadSingleLocation(data!)
            }else if data!.length == 0 && error == nil{
                print("Nothing was downloaded")
            } else if error != nil{
                print("Error happened = \(error)")
            }
        }
        task.resume()
    }
    func loadSingleLocation(jsonData:NSData) {
        
        do {
            let json: AnyObject? = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
            if let locationList = json as? NSArray
            {
                for i in 0...locationList.count-1
                {
                    if let location = locationList[i] as? NSDictionary
                    {
                        locations.append(location)
                        
                    }
                }
            }
        }
        catch let error as NSError {
            print("Error parsing, dumbass! \(error.description)")
        }
        endFunction()
    }
    func locationAt(position:Int)-> NSDictionary? {
        if(position<locations.count) {
            return locations[position]
        }
        return nil
    }
    func locationCount()-> Int {
        return locations.count
    }
    /**
    Free as much memory as you can
    */
    func didReceiveMemoryWarning() {
        locations.removeAll()
    }

}