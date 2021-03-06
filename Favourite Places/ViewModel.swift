//
//  GeocodingViewModel.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 23/5/2022.
//

import Foundation
import CoreLocation
import MapKit

///Main view model, holds instances of multiple models taht will be used to interact with the map, sunset and sunrise data, and functions to modify the appearance of the view
@MainActor class ViewModel: ObservableObject {
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
    ///function takes a string title of a place, puts it through the online API and processes the resulting Co-ordinates into the map
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
    ///Takes the current location, puts it into the API and retrieves the name of the place at those co-ordinates
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
    ///takes the current map co-ordinates and sends them through a sunrise-sunset co-ordinates and formats the results into your current time zone and displays them in Text on the view
    func lookupSunriseAndSunset() async throws{
        let urlString = "https://api.sunrise-sunset.org/json?lat=\(region.latitudeString)&lng=\(region.longitudeString)"
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }

        guard let apiResults = try? JSONDecoder().decode(SunriseSunsetAPI.self, from: data) else {
            print("couldn't work with JSON data: \(String(describing: String(data: data, encoding: .utf8)))")
            return
        }
        let dateInputFormatter = DateFormatter()
        dateInputFormatter.dateStyle = .none
        dateInputFormatter.timeStyle = .medium
        dateInputFormatter.timeZone = .init(secondsFromGMT: 0)
        let dateOutputFormatter = DateFormatter()
        dateOutputFormatter.dateStyle = .none
        dateOutputFormatter.timeStyle = .medium
        dateOutputFormatter.timeZone = .current
        
        var converted = apiResults.results
        if let time = dateInputFormatter.date(from:apiResults.results.sunrise) {
            converted.sunrise = dateOutputFormatter.string(from: time)
        }
        if let time = dateInputFormatter.date(from:apiResults.results.sunset) {
            converted.sunset = dateOutputFormatter.string(from: time)
        }
        sunrise = converted.sunrise
        sunset = converted.sunset
    }
}
