//
//  LonLatOutputs.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 12/5/2022.
//

import SwiftUI
import MapKit
///this view outputs the current latitude and longitudes co-ordinates of the map
struct LonLatOutputs: View {
    @ObservedObject var geocoder: ViewModel
    @ObservedObject var place:Place
    var body: some View {
        HStack{
            Text("Lat:")
            Text(geocoder.region.latitudeString)
        }
        HStack {
            Text("Lon:")
            Text(geocoder.region.longitudeString)
        }
    }
}

