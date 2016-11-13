//
//  WaiterTableViewCell.swift
//  encuesta
//
//  Created by Juan Pablo Morales on 11/12/16.
//  Copyright © 2016 Joshua Cafe Bar. All rights reserved.
//

import UIKit

class WaiterTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
