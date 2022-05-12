//
//  LonLatInputs.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 12/5/2022.
//

import SwiftUI
import MapKit

struct LonLatInputs: View {
    @Binding var region: MKCoordinateRegion
    @ObservedObject var place:Place
    var body: some View {
        HStack{
            Text("Lat:")
            TextField(region.latitudeString, text: $region.latitudeString) {place.updateFromMap(latitude: region.center.latitude, longitude: region.center.longitude)}
        }
        HStack {
            Text("Lon:")
                TextField(region.longitudeString, text: $region.longitudeString) {place.updateFromMap(latitude: region.center.latitude, longitude: region.center.longitude)}
        }
    }
}
