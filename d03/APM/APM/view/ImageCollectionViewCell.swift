//
//  ImageCollectionViewCell.swift
//  APM
//
//  Created by Njabulo MAJOZI on 2018/10/05.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageLoadingSpinner: UIActivityIndicatorView!
    private static var mainController: MainController!
    
    var loadImage: Int {
        set {
            if imageView.image == nil {
                fetchImage(index: newValue)
            }
        } get {
            return 0
        }
    }
    
    static func setMainController(mainController: MainController) {
        ImageCollectionViewCell.mainController = mainController
    }
    
    private func fetchImage(index: Int) {
        imageLoadingSpinner.startAnimating()
        imageLoadingSpinner.hidesWhenStopped = true
        ImageData.aNumberOfThreads = 1
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: ImageData.gImageLinks![index]) {
                do {
                    print("DOWNLOAD: Image INDEX(\(index)) URL(\(url))")
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                        self.imageView.sizeToFit()
                        self.imageLoadingSpinner.stopAnimating()
                        
                        ImageData.aNumberOfThreads = -1
                        if (ImageData.aNumberOfThreads < 1){
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                    }
                } catch let err {
                    DispatchQueue.main.async {
                        self.imageLoadingSpinner.stopAnimating()
                        ImageData.aNumberOfThreads = -1
                        if (ImageData.aNumberOfThreads < 1){
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                        
                        let alert = UIAlertController(title: "Error", message: "Cannot access to \(url)", preferredStyle: UIAlertControllerStyle.alert)
                        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                            (action) in alert.dismiss(animated: true, completion: nil)
                        })
                        alert.addAction(alertAction)
                        ImageCollectionViewCell.mainController!.present(alert, animated: true, completion: nil)
                    }
                    print("\nERROR: \(err.localizedDescription) URL(\(url))")
                }
            }
        }
    }
}
