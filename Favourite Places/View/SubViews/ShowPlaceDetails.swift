//
//  ShowPlaceDetails.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 9/5/2022.
//

import SwiftUI

struct ShowPlaceDetails: View {
    @Binding var image: Image
    @ObservedObject var place: Place
    var body: some View {
        image.aspectRatio(contentMode: .fit)
        Text(place.placeDescription != "" ? place.placeDescription : "No Description").frame(height:200)
        Spacer()
        HStack{
            Text("lat: \(place.placeLatitude)")
            Spacer()
            Text("lon: \(place.placeLongitude)")
        }    }
}
