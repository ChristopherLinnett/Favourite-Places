//
//  LocationTextOutput.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 23/5/2022.
//

import SwiftUI
import MapKit
///This view allows an input field for a place title, and has a button that will geocode this title
struct LocationTextOutput: View {
    @ObservedObject var geocoder: ViewModel
    var body: some View {
        HStack {
             Button {
                 geocoder.lookupCoordinates()
            } label: {
                Image(systemName: "magnifyingglass.circle").resizable(resizingMode: .stretch).padding(.all, 12.0)
            }.frame(width: 50, height: 50, alignment: .leading)
            TextField("", text: $geocoder.regionTitle).font(.title2).frame(height: 50)
        }
    }
}
