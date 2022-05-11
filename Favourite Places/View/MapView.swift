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
    var body: some View {
        VStack {
            Map(coordinateRegion: $region)
            HStack{
                Text("Lat:")
                TextField(region.latitudeString, text: $region.latitudeString)
            }
            
            HStack {
                Text("Lon:")
                TextField(region.longitudeString, text: $region.longitudeString)
            }
        }.navigationTitle(place.placeTitle)
    }
}

