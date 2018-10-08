//
//  token.swift
//  rush
//
//  Created by Mfundo MTHETHWA on 2018/10/06.
//  Copyright © 2018 Mfundo MTHETHWA. All rights reserved.
//

import UIKit

class Token:  CustomStringConvertible{
    var access_token: String
    var created_at: Int
    var expires_in: Int
//    var refresh_token: String
    var token_type: String
    
    init (token: NSDictionary) {
        self.access_token = token.value(forKey: "access_token") as! String
        self.created_at = token.value(forKey: "created_at") as! Int
        self.expires_in = token.value(forKey: "expires_in") as! Int
//        self.refresh_token = token.value(forKey: "refresh_token") as! String
        self.token_type = token.value(forKey: "token_type") as! String
    }
    
    var description: String {
        return "\(token_type) \(access_token)"
    }
}
