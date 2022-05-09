//
//  PlaceView.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 9/5/2022.
//

import SwiftUI

struct PlaceView: View {
    @Environment(\.editMode) var editMode
    @ObservedObject var place: Place
    var body: some View {
        List{
            Text(place.placeImageURL != "" ? place.placeImageURL : "noURL")
            Text(place.placeDescription != "" ? place.placeDescription: "noDescription")
            VStack{
                Text(place.placeLatitude)
                Text(place.placeLongitude)
            }
        }.navigationTitle(place.placeTitle)
    }

}

