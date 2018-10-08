//
//  KantoData.swift
//  kanto
//
//  Created by Njabulo MAJOZI on 2018/10/08.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import Foundation

class KantoData {
    private static var places:[String] = ["Johannesburg", "Tembisa", "Ivory Park"]
    
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
}
