//
//  DetailViewController.swift
//  encuesta
//
//  Created by Juan Pablo Morales on 11/6/16.
//  Copyright © 2016 Joshua Cafe Bar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var meseros = [AnyObject]()
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem as? NSDictionary {
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
    }

    // MARK: - Table View
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meseros.count
    }
    */

}

