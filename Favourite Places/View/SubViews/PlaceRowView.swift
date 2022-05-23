//
//  PlaceRowView.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 9/5/2022.
//

import SwiftUI
///represents a thumbnail and title for each of the places in the list.
struct PlaceRowView: View {
    @ObservedObject var place: Place
    @State var image = Image(systemName: "photo").resizable()
    var body: some View {
        HStack {
            image.aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 100, alignment: .center)
            Text(place.placeTitle)
        }
        .task {
            ///Starts process of downloading, caching and loading imagge from url
            image = await place.getImage()
        }
    }
}
