//
//  SiriData.swift
//  Siri
//
//  Created by Njabulo MAJOZI on 2018/10/11.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import Foundation

class SiriData {
    private static let recastBotAPIToken = "aa0393fa5b2aafbc98f22d9f4f447570"
    private static let forecastIOAPIToken = "e942aff1d67af98091f029e0d26f22a7"
    
    static func getRecastBotAPIToken() -> String {
        return SiriData.recastBotAPIToken
    }
    
    static func getForecastIOAPIToken() -> String {
        return SiriData.forecastIOAPIToken
    }
}
