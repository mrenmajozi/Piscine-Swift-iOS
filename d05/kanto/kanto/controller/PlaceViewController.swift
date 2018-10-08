//
//  PlaceViewController.swift
//  kanto
//
//  Created by Njabulo MAJOZI on 2018/10/08.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var placesTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return KantoData.getPlacesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = placesTableView.dequeueReusableCell(withIdentifier: "placeCell")
        cell?.textLabel?.text = KantoData.getPlace(at: indexPath.row)
        return cell!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

