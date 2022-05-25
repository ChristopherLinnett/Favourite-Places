//
//  SetAndRiseTimeView.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 23/5/2022.
//

import SwiftUI
///this view ouptus the sunrise and sunset times in text labels with corresponding icons
struct SetAndRiseTimeView: View {
    @ObservedObject var geocoder: ViewModel
    var body: some View {
        HStack {
            Label(geocoder.sunrise, systemImage: "sunrise")
            Spacer()
            Label(geocoder.sunset, systemImage: "sunset")
        }.padding()
    }
}

