//
//  GeocodingViewModel.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 23/5/2022.
//

import Foundation
import CoreLocation
import MapKit

class GeocodingVM: ObservableObject {
    var latString: String
    var lonString: String
 @Published var region: MKCoordinateRegion
 
    
    
    init(){
        latString = "50"
        lonString = "50"
        region = MKCoordinateRegion()
    }
    func lookupCoordinates(for addressName: String){
        let coder = CLGeocoder()
        coder.geocodeAddressString(addressName) { (optionalplacemarks, optionalError) in
            if let error = optionalError {
                print("error looking up \(addressName): \(error.localizedDescription)")
                return
            }
            guard let placemarks = optionalplacemarks, !placemarks.isEmpty else {
                print("Nothing found")
                return
            }
            let placemark = placemarks[0]
            guard let location = placemark.location else {
                print("mark has no location")
                return
            }
            self.region.sendToMapLat(latitude: String(location.coordinate.latitude))
            self.region.sendToMapLon(longitude: String(location.coordinate.longitude))
            self.latString = String(location.coordinate.latitude)
            self.lonString = String(location.coordinate.longitude)
        }
    }
}
