//
//  ViewController.swift
//  Supersize me
//
//  Created by Njabulo MAJOZI on 2018/10/01.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var helloWorldLabel: UILabel!
    
    @IBAction func clickMeButton(_ sender: UIButton) {
        helloWorldLabel.text = "Changed"
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

