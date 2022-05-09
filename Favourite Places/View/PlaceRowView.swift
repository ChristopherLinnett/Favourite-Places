//
//  PlaceRowView.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 9/5/2022.
//

import SwiftUI

struct PlaceRowView: View {
    @ObservedObject var place: Place
    @State var image = Image(systemName: "photo").resizable()
    var body: some View {
        HStack {
            image.aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 40, alignment: .center)
            Text(place.placeTitle)
    }
        .task {
            image = await place.getImage()
        }
    }
}
