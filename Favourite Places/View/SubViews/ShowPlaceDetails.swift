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
    @ObservedObject var geocoder: ViewModel
    var body: some View {
        image.aspectRatio(contentMode: .fit)
//        VStack {
        Text(place.placeDescription != "" ? place.placeDescription : "No Description").frame(height:200).listRowSeparator(.hidden)
            Spacer()
        NavigationLink(destination: MapView(place: place, geocoder: geocoder, locationName: "\(place.placeTitle)")) {
                HStack {
                    MapSnapshot(region: geocoder.region)
                    Text("Show \(place.placeTitle) on Map")
                }
            }
//            HStack{
//                Text("lat: \(place.placeLatitude)")
//                Spacer()
//                Text("lon: \(place.placeLongitude)")
//            }
//        }
            .listRowSeparator(.hidden)
    }
}
