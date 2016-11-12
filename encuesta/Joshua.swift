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
    var selectedLocation: NSDictionary?
    var endFunction: Void->Void
    var errorFunction: String->Void
    var waiters = [NSDictionary]()
    init() {
        self.baseUrl = "http://api.joshuacafebar.com/api/"
        self.endFunction = { Void-> Void in }
        self.errorFunction = {(x:String) -> Void in
            print(x)
        }
        self.selectedLocation = nil
    }
    /**
     Load the locations if they are not there
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
                self.errorFunction("Nothing was downloaded")
            } else if error != nil{
                self.errorFunction("Error happened = \(error)")
            }
        }
        task.resume()
    }
    /**
     Load one location given the JSONic data
    */
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
            errorFunction("Error parsing, dumbass! \(error.description)")
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
    func setSelectedLocation(location:NSDictionary, endFunction: Void->Void) {
        self.endFunction = endFunction
        self.selectedLocation = location
        self.waiters.removeAll()
        print(location["_id"])
        if let locationId = location["_id"] as? String {
            let url = NSURL(string: self.baseUrl  + "meseros?locattion=" + locationId)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url!) {
                (data, response, error) -> Void in
                if data!.length > 0 && error == nil{
                    self.loadSingleWaiter(data!)
                }else if data!.length == 0 && error == nil{
                    self.errorFunction("Nothing was downloaded")
                } else if error != nil{
                    self.errorFunction("Error happened = \(error)")
                }
            }
            task.resume()
        }
    }
    func loadSingleWaiter(jsonData:NSData) {
        
        do {
            let json: AnyObject? = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
            if let waiterList = json as? NSArray
            {
                for i in 0...waiterList.count-1
                {
                    if let waiter = waiterList[i] as? NSDictionary
                    {
                        waiters.append(waiter)
                    }
                }
            }
        }
        catch let error as NSError {
            errorFunction("Error parsing, dumbass! \(error.description)")
        }
        endFunction()
    }
    
    
    func waiterAt(position:Int)-> NSDictionary? {
        if(position<waiters.count) {
            return waiters[position]
        }
        return nil
    }
    func waiterCount()-> Int {
        return waiters.count
    }
    /**
    Free as much memory as you can
    */
    func didReceiveMemoryWarning() {
        self.locations.removeAll()
        self.waiters.removeAll()
    }

}