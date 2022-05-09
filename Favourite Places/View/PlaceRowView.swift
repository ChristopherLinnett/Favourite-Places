//
//  PlaceRowView.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 9/5/2022.
//

import SwiftUI

struct PlaceRowView: View {
    @ObservedObject var place: Place
    var body: some View {
        HStack {
            if let url = place.place_image_URL {
                Text("URL: \(url.absoluteString)")
            }
            Text(place.placeTitle)
    }
    }
}
