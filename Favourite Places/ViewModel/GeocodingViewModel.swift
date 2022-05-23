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
    @Published var sunriseSunset = SunriseSunset(sunrise: "unknown", sunset: "unknown")
    var sunrise: String {
        get { sunriseSunset.sunrise }
        set { sunriseSunset.sunrise = newValue }
    }
    var sunset: String {
        get { sunriseSunset.sunset }
        set { sunriseSunset.sunset = newValue}
    }
    
    
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
    
    func lookupName() {
        let coder = CLGeocoder()
        coder.reverseGeocodeLocation(CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)){ [self] (optionalplacemarks, optionalError) in
            if let error = optionalError {
                print("error looking up \(self.region.center.latitude), \(self.region.center.longitude): \(error.localizedDescription)")
                return
            }
            guard let placemarks = optionalplacemarks, !placemarks.isEmpty else {
                print("Nothing found")
                return
            }
            let placemark = placemarks[0]
            let title = placemark.locality ?? placemark.subAdministrativeArea ?? placemark.administrativeArea ?? placemark.country ?? ""
             self.regionTitle = "\(title)"
        }
    }
    
    func lookupSunriseAndSunset() {
        let urlString = "https://api.sunrise-sunset.org/json?lat=\(region.latitudeString)&lng=\(region.longitudeString)"
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        guard let jsonData = try? Data(contentsOf: url) else {
            print("couldn't get sunrise/sunset")
            return
        }
        guard let apiResults = try? JSONDecoder().decode(SunriseSunsetAPI.self, from: jsonData) else {
            print("couldn't work with JSON data: \(String(describing: String(data: jsonData, encoding: .utf8)))")
            return
        }
        sunriseSunset = apiResults.results
    }
}
