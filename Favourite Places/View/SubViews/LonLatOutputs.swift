//
//  LonLatOutputs.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 12/5/2022.
//

import SwiftUI
import MapKit

struct LonLatOutputs: View {
    @Binding var region: MKCoordinateRegion
    @ObservedObject var place:Place
    var body: some View {
        HStack{
            Text("Lat:")
            Text(region.latitudeString)
        }
        HStack {
            Text("Lon:")
            Text(region.longitudeString)
        }
    }
}

