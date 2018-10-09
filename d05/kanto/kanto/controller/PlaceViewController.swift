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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // EVENT: SELECTED CELL
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.placesTableView.deselectRow(at: indexPath, animated: true)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if let controllers = appDelegate.window?.rootViewController?.childViewControllers {
            for controller in controllers {
                if let mapController = controller as? MapViewController {
                    mapController.placeLocation = KantoData.getPlace(at: indexPath.row)
                    self.tabBarController?.selectedIndex = 0
                    break
                }
            }
        }
    }
    
    // TABLE CELLS TOTAL
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return KantoData.getPlacesCount()
    }
    
    // TABLE CELL DESIGN
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = placesTableView.dequeueReusableCell(withIdentifier: "placeCell")
        cell?.textLabel?.text = KantoData.getPlace(at: indexPath.row)
        return cell!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

