//
//  PlaceView.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 9/5/2022.
//

import SwiftUI
///This is the detail view that will show either the details of each place or show the editing fields of an individual place
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
        ///while edit mode is disabled, the list will present information to the user, when enabled will show editing fields.
        List{
            if editMode?.wrappedValue == .active  {
                EditPlaceDetails(placeTitle: $placeTitle, placeImageURL: $placeImageURL, placeDescription: $placeDescription, placeLatitude: $placeLatitude, placeLongitude: $placeLongitude, place: place)
            } else {
                ShowPlaceDetails(image: $image, place: place)
            }
        }.navigationTitle(place.placeTitle)
            .task {
                image = await place.getImage()
            }
        ///Disabling edit mode commits the editing fields to be saved
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

