//
//  MapView.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 11/5/2022.
//

import SwiftUI
import MapKit
///A view that contains an interactive map detail view
struct MapView: View {
    @ObservedObject var place:Place
    @ObservedObject var geocoder: ViewModel
    @State var locationName: String
    @Environment(\.editMode) var editMode
    var body: some View {
        VStack {
            if editMode?.wrappedValue == .active {
                LocationTextOutput(geocoder: geocoder)
                Map(coordinateRegion: $geocoder.region)
                LonLatInputs(geocoder: geocoder, place:place)
            } else {
                Map(coordinateRegion: $geocoder.region)
                LonLatOutputs(geocoder: geocoder, place:place)

            }
        }.navigationTitle(place.placeTitle)
            .navigationBarItems(trailing: EditButton())
            .onAppear{
                geocoder.regionTitle = place.placeTitle
            }
    }
}

