//
//  LonLatInputs.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 12/5/2022.
//

import SwiftUI
import MapKit

struct LonLatInputs: View {
    @State var latInput: String = ""
    @State var lonInput: String = ""
    @Binding var region: MKCoordinateRegion
    @ObservedObject var place:Place
    var body: some View {
        HStack{
            VStack {
                HStack{
                    Text("Lat:")
                    TextField(region.latitudeString, text: $latInput).onSubmit {
                        region.sendToMapLat(latitude: latInput)
                        latInput = ""
                        place.updateFromMap(latitude: region.center.latitude, longitude: region.center.longitude)}
                }
                HStack {
                    Text("Lon:")
                    TextField(region.longitudeString, text: $lonInput) .onSubmit {
                        region.sendToMapLon(longitude: lonInput)
                        lonInput = ""
                        place.updateFromMap(latitude: region.center.latitude, longitude: region.center.longitude)}
                }
        
            }
            Button {
                print("send co-ordinates to geocode")
            } label: {
                Image(systemName: "mappin.and.ellipse").resizable()
            }.frame(width:25, height: 25).padding()
            }.onAppear {
                    region.sendToMapLat(latitude: place.placeLatitude)
                    region.sendToMapLon(longitude: place.placeLongitude)
                    latInput = ""
                    lonInput = ""
                }.onDisappear {
                    region.sendToMapLat(latitude: latInput)
                    region.sendToMapLon(longitude: lonInput)
                    place.updateFromMap(latitude: region.center.latitude, longitude: region.center.longitude)
                }
            
        }
    }
