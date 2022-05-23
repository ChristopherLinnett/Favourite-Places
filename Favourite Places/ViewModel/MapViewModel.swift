//
//  MapViewModel.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 11/5/2022.
//

import Foundation
import MapKit
import Combine

extension MKCoordinateRegion {
    var latitudeString: String {
        get {String(center.latitude)
        }
        set {guard let lat = CLLocationDegrees(newValue), abs(lat)<=90 else { return }
            center.latitude = lat
        }
    }
    var longitudeString: String {
        get {String(center.longitude)
        }
        set {guard let lon = CLLocationDegrees(newValue), abs(lon)<=180 else { return }
            center.longitude = lon
        }
    }
    mutating func sendToMapLat(latitude: String) {
        guard let _ = Float(latitude) else {return}
        latitudeString = latitude
    }
    mutating func sendToMapLon(longitude: String){
        guard let _ = Float(longitude) else {return}
        longitudeString = longitude
    }
}
