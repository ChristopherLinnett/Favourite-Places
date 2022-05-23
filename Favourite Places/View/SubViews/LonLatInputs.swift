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
    @ObservedObject var geocoder: GeocodingVM
    @ObservedObject var place:Place
    var body: some View {
        HStack{
            VStack {
                HStack{
                    Text("Lat:")
                    TextField(geocoder.region.latitudeString, text: $latInput).onSubmit {
                        geocoder.region.sendToMapLat(latitude: latInput)
                        latInput = ""
                        place.updateFromMap(latitude: geocoder.region.center.latitude, longitude: geocoder.region.center.longitude)}
                }
                HStack {
                    Text("Lon:")
                    TextField(geocoder.region.longitudeString, text: $lonInput) .onSubmit {
                        geocoder.region.sendToMapLon(longitude: lonInput)
                        lonInput = ""
                        place.updateFromMap(latitude: geocoder.region.center.latitude, longitude: geocoder.region.center.longitude)}
                }
        
            }
            Button {
                geocoder.region.sendToMapLat(latitude: latInput)
                geocoder.region.sendToMapLon(longitude: lonInput)
                latInput = ""
                lonInput = ""

                geocoder.lookupName()
            } label: {
                Image(systemName: "mappin.and.ellipse").resizable()
            }.frame(width:25, height: 25).padding()
            }.onAppear {
                geocoder.region.sendToMapLat(latitude: place.placeLatitude)
                geocoder.region.sendToMapLon(longitude: place.placeLongitude)
                    latInput = ""
                    lonInput = ""
                }.onDisappear {
                    geocoder.region.sendToMapLat(latitude: latInput)
                    geocoder.region.sendToMapLon(longitude: lonInput)
                    place.updateFromMap(latitude: geocoder.region.center.latitude, longitude: geocoder.region.center.longitude)
                }
            
        }
    }
