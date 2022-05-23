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
    @Published var regionTitle: String
    @Published var region: MKCoordinateRegion
 
    
    
    init(){
        regionTitle = ""
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), latitudinalMeters: 500, longitudinalMeters: 500)
    }
    func lookupCoordinates(){
        let coder = CLGeocoder()
        coder.geocodeAddressString(regionTitle) { (optionalplacemarks, optionalError) in
            if let error = optionalError {
                print("error looking up \(self.regionTitle): \(error.localizedDescription)")
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

        }
    }
}
