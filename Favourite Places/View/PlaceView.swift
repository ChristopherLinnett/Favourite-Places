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
    @State var placeTitle: String = ""
    @State var placeImageURL: String = ""
    @State var placeDescription: String = ""
    @State var placeLatitude: String = ""
    @State var placeLongitude: String = ""
    @State var image = Image(systemName: "photo")
    
    var body: some View {
        
        List{
            if editMode?.wrappedValue == .active  {
                TextField("Enter Place Name", text: $placeTitle) { $place.placeTitle.wrappedValue = placeTitle }
                TextField("Enter Image URL", text: $placeImageURL) { $place.placeImageURL.wrappedValue = placeImageURL }
                TextField("Enter Place Description", text: $placeDescription) { $place.placeDescription.wrappedValue = placeDescription }
                
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
            } else {
                image.aspectRatio(contentMode: .fit)
                Text(place.placeDescription != "" ? place.placeDescription: "noDescription")
                Spacer()
                HStack{
                    Text("lat: \(place.placeLatitude)")
                    Spacer()
                    Text("lon: \(place.placeLongitude)")
                }
            }
        }.navigationTitle(place.placeTitle)
            .task {
                image = await place.getImage()
            }
    }
}

