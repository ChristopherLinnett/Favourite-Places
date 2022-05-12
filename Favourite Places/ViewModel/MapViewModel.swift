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
    @discardableResult
    mutating func sendToMapLat(latitude: String)->Bool {
        guard let lat = Float(latitude) else {return false}
        if lat >= -90 && lat <= 90 {
        latitudeString = latitude
        } else {return false}
        return true
    }
    @discardableResult
    mutating func sendToMapLon(longitude: String)->Bool {
        guard let lon = Float(longitude) else {return false}
        if lon >= -180 && lon <= 180 {
        longitudeString = longitude
        } else {return false}
        return true

    }
    
}
