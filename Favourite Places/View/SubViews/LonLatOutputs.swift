//
//  LonLatOutputs.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 12/5/2022.
//

import SwiftUI
import MapKit

struct LonLatOutputs: View {
    @ObservedObject var geocoder: GeocodingVM
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

