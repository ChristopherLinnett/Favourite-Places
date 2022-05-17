//
//  MapSnapshotViewModel.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 18/5/2022.
//

import Foundation
import MapKit

extension MapSnapshot {
    
    func generateSnapshot(width: CGFloat, height: CGFloat, region: MKCoordinateRegion) {

      // Map options.
      let mapOptions = MKMapSnapshotter.Options()
      mapOptions.region = region
      mapOptions.size = CGSize(width: width, height: height)

      // Create the snapshotter and run it.
      let snapshotter = MKMapSnapshotter(options: mapOptions)
      snapshotter.start { (snapshotOrNil, errorOrNil) in
        if let error = errorOrNil {
          print(error)
          return
        }
        if let snapshot = snapshotOrNil {
          self.snapshotImage = snapshot.image
        }
      }
    }
    
}
