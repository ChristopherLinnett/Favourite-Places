//
//  PlaceView.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 9/5/2022.
//

import SwiftUI
let defaultImage = Image(systemName: "photo")

struct PlaceView: View {
    @Environment(\.editMode) var editMode
    @ObservedObject var place: Place
    @State var placeTitle: String = ""
    @State var placeImageURL: String = ""
    @State var placeDescription: String = ""
    @State var placeLatitude: String = ""
    @State var placeLongitude: String = ""
    
    var body: some View {
        
        List{
            if editMode?.wrappedValue == .active  {
                TextField("Enter Place Name", text: $placeTitle) { $place.placeTitle.wrappedValue = placeTitle }
                TextField("Enter Image URL", text: $placeImageURL) { $place.placeImageURL.wrappedValue = placeImageURL }
                TextField("Enter Place Description", text: $placeDescription) { $place.placeDescription.wrappedValue = placeDescription }
                
                VStack{
                    HStack {
                        Text("Latitude: ")
                        TextField("Place's Latitude", text: $placeLatitude) { $place.placeLatitude.wrappedValue = placeLatitude }
                    }
                    HStack {
                        Text("Longitude: ")
                        TextField("Place's Longitude", text: $placeLongitude) { $place.placeLatitude.wrappedValue = placeLatitude }
                    }
                }
            } else {
                image(for: place.place_image_URL).aspectRatio(contentMode: .fit)
                Text(place.placeDescription != "" ? place.placeDescription: "noDescription")
                VStack{
                    Text("lat: \(place.placeLatitude)")
                    Text("lon: \(place.placeLongitude)")
                }
            }
        }.navigationTitle(place.placeTitle)
    }
    func image(for url: URL?) -> Image {
        guard let url = url,
              let data = try? Data(contentsOf: url),
              let uiImg = UIImage(data: data) else {return defaultImage}
        return Image(uiImage: uiImg).resizable()
    }
}

