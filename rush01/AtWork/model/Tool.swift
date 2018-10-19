//
//  MapboxGeocoder.swift
//  AtWork
//
//  Created by Njabulo MAJOZI on 2018/10/12.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import Foundation
import MapboxGeocoder
#if !os(tvOS)
    import Contacts
#endif

class Tool {
    private static let geocoder = Geocoder(accessToken: "pk.eyJ1IjoibXJlbm1ham96aSIsImEiOiJjam41ank3ZGgzcXlnM3BxeWltOG80YmI3In0.K-6yKKNPjW2der9PqohRyA")
    
    static func getCoordinates(address _address: String) -> [CLLocationDegrees]? {
        var _results:[CLLocationDegrees]?
        let _options = ForwardGeocodeOptions(query: _address)
        
        let task = geocoder.geocode(_options) { (placemarks, attribution, error) in
            guard let placemark = placemarks?.first else {
                return
            }
            
            if let _coordinate = placemark.location?.coordinate {
                //print("\(_coordinate.latitude), \(_coordinate.longitude)")
                _results = [_coordinate.latitude, _coordinate.longitude]
            }
            
            #if !os(tvOS)
                let formatter = CNPostalAddressFormatter()
                //print(formatter.string(from: placemark.postalAddress!))
            #endif
        }
        
        
        
        return _results
    }
}
