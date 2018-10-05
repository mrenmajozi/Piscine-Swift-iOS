//
//  MainController.swift
//  APM
//
//  Created by Njabulo MAJOZI on 2018/10/05.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import UIKit

class MainController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    var selectedItem:Int = -1
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let imageLinksList = ImageData.gImageLinks {
            return imageLinksList.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageViewPrototypeCell", for: indexPath) as! ImageCollectionViewCell
        ImageCollectionViewCell.setMainController(mainController: self)
        cell.loadImage = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = indexPath.row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = imagesCollectionView.indexPathsForSelectedItems?.first?.item {
            FullImageController.imageURL = ImageData.gImageLinks![index]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

