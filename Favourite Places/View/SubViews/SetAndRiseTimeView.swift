//
//  SetAndRiseTimeView.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 23/5/2022.
//

import SwiftUI

struct SetAndRiseTimeView: View {
    var body: some View {
        HStack {
            Label("Sunrise", systemImage: "sunrise")
            Spacer()
            Label("Sunset", systemImage: "sunset")
        }.padding()
    }
}

