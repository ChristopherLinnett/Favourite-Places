//
//  MapView.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 11/5/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var place:Place
    @ObservedObject var geocoder: GeocodingVM
    @State var locationName: String
    @Environment(\.editMode) var editMode
    var body: some View {
        VStack {
            if editMode?.wrappedValue == .active {
                LocationTextOutput(locationName: $locationName, geocoder: geocoder)
                Map(coordinateRegion: $geocoder.region)
                LonLatInputs(geocoder: geocoder, place:place)
            } else {
                Map(coordinateRegion: $geocoder.region)
                LonLatOutputs(geocoder: geocoder, place:place)

            }
        }.navigationTitle(place.placeTitle)
            .navigationBarItems(trailing: EditButton())
        
    }
}

