//
//  ViewController.swift
//  Forum
//
//  Created by Njabulo MAJOZI on 2018/10/06.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let CONSUMER_KEY = "9ba8476a64d9b3e1e8c1ba750f5bbc082c68c245d9d0f8e0e1cd6636e2d1bdcc"
    let CONSUMER_SECRET = "2ba2d2bcd2c7c9109d6404f00dbc74e8fceeb046c6e32d537094c70cdc6a52e6"
    let url = NSURL(string: "https://api.intra.42.fr/oauth/token")

    override func viewDidLoad() {
        super.viewDidLoad()
        createToken()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createToken() {
        //let BEARER = ((CONSUMER_KEY + ":" + CONSUMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        //request.setValue("Basic \(BEARER)", forHTTPHeaderField: "Authorization")
        //request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials&client_id=\(CONSUMER_KEY)&client_secret=\(CONSUMER_SECRET)".data(using: String.Encoding.utf8)
        
        
        let session = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            print(response!)
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    print(d)
                    if let disc: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        print(disc)
                        if let token = disc["access_token"] {
                            print(token)
                        }
                    }
                }
                catch (let err) {
                    print(err)
                }
            }
        }
        session.resume()
    }
}

