//
//  FullImageController.swift
//  APM
//
//  Created by Njabulo MAJOZI on 2018/10/05.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import UIKit

class FullImageController: UIViewController {
    static var imageURL = ""
    private var imageView: UIImageView!
    
    @IBOutlet weak var imageLoadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLoadingSpinner.startAnimating()
        imageLoadingSpinner.hidesWhenStopped = true
        ImageData.aNumberOfThreads = 1
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: FullImageController.imageURL) {
                do {
                    print("DOWNLOAD: Image URL(\(url))")
                    var data: Data? = nil
                    data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        
                        
                        if data != nil  {
                            let image: UIImage = UIImage(data: data!)!
                            self.imageView.image = image
                            self.imageView.sizeToFit()
                        }
                        
                        self.imageLoadingSpinner.stopAnimating()
                        
                        ImageData.aNumberOfThreads = -1
                        if (ImageData.aNumberOfThreads < 1){
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                        self.scrollView.addSubview(self.imageView!)
                    }
                } catch let err {
                    print("\nERROR: \(err.localizedDescription) URL(\(url))")
                    self.imageLoadingSpinner.stopAnimating()
                    
                    ImageData.aNumberOfThreads = -1
                    if (ImageData.aNumberOfThreads < 1){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                    self.scrollView.addSubview(self.imageView!)
                }
            }
    }
    }
}
