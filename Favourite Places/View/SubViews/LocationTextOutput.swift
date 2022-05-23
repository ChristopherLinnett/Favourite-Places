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
                Image(systemName: "magnifyingglass.circle").resizable(resizingMode: .stretch).padding(.all, 12.0)
            }.frame(width: 50, height: 50, alignment: .leading)
            TextField("Noosa Heads", text: $locationName).font(.title2).frame(height: 50)
        }
    }
}

struct LocationTextOutput_Previews: PreviewProvider {
    static var previews: some View {
        LocationTextOutput(locationName: "Big Ben")
    }
}
