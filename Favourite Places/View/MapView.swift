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
            Map(coordinateRegion: $region)
            if editMode?.wrappedValue == .active {
                LonLatInputs(region: $region, place:place)
            } else {
                LonLatOutputs(region: $region, place:place)
            }
        }.navigationTitle(place.placeTitle)
            .navigationBarItems(trailing: EditButton())
        
            .onAppear {
                region.sendToMap(latitude: place.placeLatitude,longitude: place.placeLongitude)
            }
            .onDisappear {
                place.updateFromMap(latitude: region.center.latitude, longitude: region.center.longitude)
            }
    }
}

