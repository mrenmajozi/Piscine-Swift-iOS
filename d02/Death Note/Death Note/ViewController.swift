//
//  ViewController.swift
//  Death Note
//
//  Created by Njabulo MAJOZI on 2018/10/04.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    var passedData:(String, String, String)!
    
    
    var sPassedData: (String, String, String)? {
        set {
            passedData = newValue!
        }
        
        get {
            return passedData
        }
    }
    
    // Table Row Size
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (Data.gpeople.count)
    }
    
    // Each Cell Content
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let prototypeCellIdentifier = "noteCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: prototypeCellIdentifier) as! PersonTableViewCell
        cell.person = Data.gpeople[indexPath.row]
        return cell
    }
    
    // Reload when view active
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    // Segue
    @IBAction func unwindToFirst(sender: UIStoryboardSegue) {
        
    }
    

    // Loading view setup
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    // Memory Manangement
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

