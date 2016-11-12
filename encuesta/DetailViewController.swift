//
//  DetailViewController.swift
//  encuesta
//
//  Created by Juan Pablo Morales on 11/6/16.
//  Copyright © 2016 Joshua Cafe Bar. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    var myJoshua:Joshua = Joshua()
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem as? NSDictionary {
            myJoshua.setSelectedLocation(detail, endFunction: refreshLocationTable)
            if let name = detail["name"] as? String {
                self.navigationItem.title = "Meseros de " + name
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        myJoshua.didReceiveMemoryWarning()
    }

    // MARK: - Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myJoshua.waiterCount()
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        if let object = myJoshua.waiterAt(indexPath.row)! as NSDictionary? {
            let name = object["name"] as? String
            cell.textLabel!.text = name
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    func refreshLocationTable() {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }

}

