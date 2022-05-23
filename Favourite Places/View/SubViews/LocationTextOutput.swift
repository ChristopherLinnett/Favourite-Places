//
//  LocationTextOutput.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 23/5/2022.
//

import SwiftUI
import MapKit

struct LocationTextOutput: View {
    @Binding var locationName: String
    @ObservedObject var geocoder: GeocodingVM
    var body: some View {
        HStack {
             Button {
                geocoder.lookupCoordinates(for: locationName)
            } label: {
                Image(systemName: "magnifyingglass.circle").resizable(resizingMode: .stretch).padding(.all, 12.0)
            }.frame(width: 50, height: 50, alignment: .leading)
            TextField("", text: $locationName).font(.title2).frame(height: 50)
        }
    }
}
