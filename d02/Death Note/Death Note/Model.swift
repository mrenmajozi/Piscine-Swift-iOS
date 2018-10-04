//
//  Model.swift
//  Death Note
//
//  Created by Njabulo MAJOZI on 2018/10/04.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import Foundation

class Data {
    private static var people: [(String, String, String)] = [
        ("Berenice", "25 Oct 2018 14:23:42", "Taxi crash on Heidelberg Road"),
        ("Daniel", "5 Nov 2018 14:24:42", "Natural death"),
        ("Jessenia", "12 Dev 2018 05:29:18", "Suicide")
    ]
    
    static var gpeople: [(String, String, String)] {
        get {
            return Data.people
        }
        set {
            Data.people.append(newValue[0])
        }
    }
}
