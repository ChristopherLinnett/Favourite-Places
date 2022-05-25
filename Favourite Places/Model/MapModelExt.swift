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
    ///A string conversion of the map's current latitude
    var latitudeString: String {
        get {String(center.latitude)
        }
        set {guard let lat = CLLocationDegrees(newValue), abs(lat)<=90 else { return }
            center.latitude = lat
        }
    }
    ///A string conversion of the map's current longitude
    var longitudeString: String {
        get {String(center.longitude)
        }
        set {guard let lon = CLLocationDegrees(newValue), abs(lon)<=180 else { return }
            center.longitude = lon
        }
    }
    ///Takes in a latitude string value and updates the map in the current view
    mutating func sendToMapLat(latitude: String) {
        guard let _ = Float(latitude) else {return}
        latitudeString = latitude
    }
    ///Takes in a longitude string value and updates the map in the current view
    mutating func sendToMapLon(longitude: String){
        guard let _ = Float(longitude) else {return}
        longitudeString = longitude
    }
}
