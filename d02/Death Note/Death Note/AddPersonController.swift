//
//  AddPersonController.swift
//  Death Note
//
//  Created by Njabulo MAJOZI on 2018/10/04.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import UIKit

class AddPersonController: UIViewController{
    @IBOutlet weak var nameEditLabel: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionEditLabel: UITextView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nameContent = nameEditLabel!.text {
            if nameContent.count > 0 {
                var descriptionContent = ""
                if let desCont = descriptionEditLabel!.text {
                    descriptionContent = desCont
                }
                let dateContent = "\(datePicker.date)"
                
                Data.gpeople = [(nameContent, dateContent, descriptionContent)]
                
                let latestItemIndex: Int = (Data.gpeople.count - 1)
                print("Name: \(Data.gpeople[latestItemIndex].0)\nDate: \(Data.gpeople[latestItemIndex].1)\nDescription: \(Data.gpeople[latestItemIndex].2)")
            }
        }
        
        let destVC = segue.destination as! ViewController
        destVC.passedData = Data.gpeople[Data.gpeople.count - 1]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.setDate(Date(), animated: true)
        datePicker.minimumDate = Date()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
