//
//  KantoData.swift
//  kanto
//
//  Created by Njabulo MAJOZI on 2018/10/08.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import Foundation

class KantoData {
    private static var places:[String] = ["Pretoria", "Durban", "Cape Town"]
    private static let pins:[String] = ["greenPin", "bluePin", "purplePin", "yellowPin", "redPin", "blackPin"]
    
    static func addPlace(nameOfPlace place: String) {
        KantoData.places.append(place)
    }
    
    static func getPlaces() -> [String] {
        return KantoData.places
    }
    
    static func getPlace(at index: Int) -> String {
        return KantoData.places[index]
    }
    
    static func getPlacesCount() -> Int {
        return KantoData.places.count
    }
    
    static func getRandomPin() -> String {
        let rand = Int(arc4random_uniform(UInt32(pins.count)))
        return KantoData.pins[rand]
    }
}
