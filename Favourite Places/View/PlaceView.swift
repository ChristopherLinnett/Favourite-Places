//
//  PlaceView.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 9/5/2022.
//

import SwiftUI

struct PlaceView: View {
    @ObservedObject var place: Place
    var body: some View {
        List{
            Text(place.placeTitle)
        }
    }
}

