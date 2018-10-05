//
//  ImageData.swift
//  APM
//
//  Created by Njabulo MAJOZI on 2018/10/05.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

class ImageData {
    static var imageLinks:[String] = [
        "https://www.nasa.gov/sites/default/files/thumbnails/image/expedition_56_landing_181004.jpg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/18-081.png",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/pia22766-nasa.jpg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/pia22486-16.jpg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/pia22486-16.jpge"
    ]
    
    static var numberOfThreads = 0
    
    static var gImageLinks:[String]? {
        set {
            ImageData.imageLinks.append(newValue![0])
        }
        get {
            return imageLinks
        }
    }
    
    static var aNumberOfThreads: Int {
        get {
            return numberOfThreads
        } set {
            ImageData.numberOfThreads += newValue
        }
    }
}
