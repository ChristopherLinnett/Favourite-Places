//
//  MapViewModel.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 11/5/2022.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    var latitudeString: String {
        get {String(center.latitude)
        }
        set {guard let lat = CLLocationDegrees(newValue) else {return}
            center.latitude = lat
        }
        }
    var longitudeString: String {
        get {String(center.longitude)
        }
        set {guard let lon = CLLocationDegrees(newValue) else {return}
            center.longitude = lon
        }
}
    mutating func sendToMap(latitude: String, longitude: String) {
        latitudeString = latitude
        longitudeString = longitude
    }
}
