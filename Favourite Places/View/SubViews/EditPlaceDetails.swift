//
//  presentPlaceDetails.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 9/5/2022.
//

import SwiftUI

struct EditPlaceDetails: View {
    @Binding var placeTitle: String
    @Binding var placeImageURL: String
    @Binding var placeDescription: String
    @Binding var placeLatitude: String
    @Binding var placeLongitude: String
    @ObservedObject var place: Place
    
    var body: some View {
        TextField("Enter Place Name", text: $placeTitle) { $place.placeTitle.wrappedValue = placeTitle }
        TextField("Enter Image URL", text: $placeImageURL) { $place.placeImageURL.wrappedValue = placeImageURL }
        TextEditor(text: $placeDescription).frame(height: 200, alignment: .center)
        HStack{
            HStack {
                Text("Lat: ")
                TextField("Lat", text: $placeLatitude) { $place.placeLatitude.wrappedValue = placeLatitude }
            }
            Spacer()
            HStack {
                Text("Lon: ")
                TextField("Lon", text: $placeLongitude) { $place.placeLatitude.wrappedValue = placeLatitude }
            }
    }
}
}
