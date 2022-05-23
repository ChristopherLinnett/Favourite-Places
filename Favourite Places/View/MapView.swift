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
    @Binding var region: MKCoordinateRegion
    @Environment(\.editMode) var editMode
    var body: some View {
        VStack {
            if editMode?.wrappedValue == .active {
                LocationTextOutput(locationName: "")
                Map(coordinateRegion: $region)
                LonLatInputs(region: $region, place:place)
            } else {
                Map(coordinateRegion: $region)
                LonLatOutputs(region: $region, place:place)

            }
        }.navigationTitle(place.placeTitle)
            .navigationBarItems(trailing: EditButton())
        
    }
}

