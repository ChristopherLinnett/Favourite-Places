//
//  LocationTextOutput.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 23/5/2022.
//

import SwiftUI

struct LocationTextOutput: View {
    @State var locationName: String
    var body: some View {
        HStack {
            Button {
                print("finding co-ords")
            } label: {
                Image(systemName: "magnifyingglass.circle").resizable()
            }.frame(width: 30, height: 30, alignment: .leading)
            TextField("Noosa Heads", text: $locationName).font(.title2).frame(height: 50)
        }
    }
}

