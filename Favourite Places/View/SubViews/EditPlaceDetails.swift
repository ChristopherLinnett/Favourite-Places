//
//  presentPlaceDetails.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 9/5/2022.
//

import SwiftUI
///this view gives access to editing tools for making changes to each of the places in this applicaiton
struct EditPlaceDetails: View {
    @Binding var placeTitle: String
    @Binding var placeImageURL: String
    @Binding var placeDescription: String
    @Binding var placeLatitude: String
    @Binding var placeLongitude: String
    @ObservedObject var place: Place
    
    var body: some View {
        TextField("Enter Place Name", text: $placeTitle) { $place.placeTitle.wrappedValue = placeTitle }.frame(height: 50)
        TextField("Enter Image URL", text: $placeImageURL) { $place.placeImageURL.wrappedValue = placeImageURL }.frame(height: 50)
        VStack {
            VStack {
                Text("Enter Location Details:").fontWeight(.heavy)
                TextEditor(text: $placeDescription).frame(height: 200, alignment: .center)
            }
            Spacer()
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
}
