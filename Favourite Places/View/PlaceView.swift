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
            if editMode?.wrappedValue == .active  {
                TextField("Enter Place Name", text: $place.placeTitle)
                TextField("Enter Image URL", text: $place.placeImageURL)
                TextField("Enter Place Description", text: $place.placeDescription)
                
                VStack{
                    HStack {
                        Text("Latitude: ")
                        TextField("Place's Latitude", text: $place.placeLatitude)}
                    HStack {
                        Text("Longitude: ")
                        TextField("Place's Longitude", text: $place.placeLongitude)}
                }
            } else {
                Text(place.placeImageURL != "" ? place.placeImageURL : "noURL")
                Text(place.placeDescription != "" ? place.placeDescription: "noDescription")
                VStack{
                    Text("lat: \(place.placeLatitude)")
                    Text("lon: \(place.placeLongitude)")
                }
            }
        }.navigationTitle(place.placeTitle)
    }
    
}

