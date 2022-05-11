//
//  ShowPlaceDetails.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 9/5/2022.
//

import SwiftUI
import MapKit
///This view presents each of the datapoints of the place within the file, and displays an image that is sourced from a url
struct ShowPlaceDetails: View {
    @Binding var image: Image
    @ObservedObject var place: Place
    @State var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), latitudinalMeters: 5000, longitudinalMeters: 5000)
    var body: some View {
        image.aspectRatio(contentMode: .fit)
        VStack {
            Text(place.placeDescription != "" ? place.placeDescription : "No Description").frame(height:200)
            Spacer()
            NavigationLink(destination: MapView(place: place, region: $region)) {
                Text("Show on Map")
            }
            HStack{
                Text("lat: \(place.placeLatitude)")
                Spacer()
                Text("lon: \(place.placeLongitude)")
            }
        }.onAppear {
            if region.center.latitude < 1 && region.center.latitude > -1  && region.center.longitude < 1 && region.center.longitude > -1 {
            region.latitudeString = place.placeLatitude
                region.longitudeString = place.placeLongitude } else {
                    place.placeLatitude = String(region.center.latitude)
                    place.placeLongitude = String(region.center.longitude)
                }
        }
    }
}
