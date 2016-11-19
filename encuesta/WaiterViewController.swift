//
//  WaiterViewController.swift
//  encuesta
//
//  Created by Juan Pablo Morales on 11/13/16.
//  Copyright © 2016 Joshua Cafe Bar. All rights reserved.
//

import UIKit

class WaiterViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var waiterImageView: UIImageView!
    
    var myJoshua: Joshua?
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let waiter = self.detailItem as? NSDictionary {
            let waiterName: String? = waiter["name"] as? String
            self.navigationItem.title = waiterName
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Actions
    
    @IBAction func sendEvaluation(sender: UIButton) {
    }
    
}
