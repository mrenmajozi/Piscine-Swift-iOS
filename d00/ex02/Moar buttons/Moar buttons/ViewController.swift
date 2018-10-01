//
//  ViewController.swift
//  Moar buttons
//
//  Created by Njabulo MAJOZI on 2018/10/01.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayScreenLabel: UILabel!
    
    @IBAction func numberButton(_ sender: UIButton) {
        displayScreenLabel.text = displayScreenLabel.text! + String(sender.tag)
        print("Clicked: " + String(sender.tag))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

