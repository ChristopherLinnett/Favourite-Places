//
//  SetAndRiseTimeView.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 23/5/2022.
//

import SwiftUI

struct SetAndRiseTimeView: View {
    @ObservedObject var geocoder: GeocodingVM
    var body: some View {
        HStack {
            Label(geocoder.sunrise, systemImage: "sunrise")
            Spacer()
            Label(geocoder.sunset, systemImage: "sunset")
        }.padding()
    }
}

