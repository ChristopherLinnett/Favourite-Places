//
//  MapSnapshot.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 18/5/2022.
//

import SwiftUI
import MapKit

struct MapSnapshot: View {
    let region: MKCoordinateRegion
    @State public var snapshotImage: UIImage? = nil

    var body: some View {
        Group {
              if let image = snapshotImage {
                Image(uiImage: image)
              } else {
                ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .background(Color(UIColor.secondarySystemBackground))
              }
        }.onAppear {
            generateSnapshot(width: 100, height: 80, region: region)
        }
          }
}
