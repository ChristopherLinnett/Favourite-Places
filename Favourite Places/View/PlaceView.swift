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
                EditPlaceDetails(placeTitle: $placeTitle, placeImageURL: $placeImageURL, placeDescription: $placeDescription, placeLatitude: $placeLatitude, placeLongitude: $placeLongitude, place: place)
            } else {
                image.aspectRatio(contentMode: .fit)
                Text(place.placeDescription != "" ? place.placeDescription : "No Description").frame(height:200)
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
            .onChange(of: editMode!.wrappedValue, perform: { value in
              if value.isEditing {
                  placeTitle = place.placeTitle
                  placeImageURL = place.placeImageURL
                  placeDescription = place.placeDescription
                  placeLatitude = place.placeLatitude
                  placeLongitude = place.placeLongitude
              } else {
                  place.commitValues(title: placeTitle, imageURL: placeImageURL,description: placeDescription,lat: placeLatitude,lon: placeLongitude)
              }
            })
    }
}

