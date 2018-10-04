//
//  PersonTableViewCell.swift
//  Death Note
//
//  Created by Njabulo MAJOZI on 2018/10/04.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var person : (String, String, String)? {
        didSet {
            if let p = person {
                nameLabel?.text = p.0
                dateTimeLabel?.text = p.1
                descriptionLabel?.text = p.2
            }
        }
    }
}
