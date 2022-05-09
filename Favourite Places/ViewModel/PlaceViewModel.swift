//
//  PlaceViewModel.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 9/5/2022.
//
import CoreData
import Foundation
import SwiftUI

extension Place {
    ///non-optional ViewModel Properties for (optionals) 'place_title' `place_description` `place_Image_URL` database attributes
    var placeTitle: String {
        get { place_title ?? ""}
        set { place_title = newValue }
    }
    var placeDescription: String {
        get { place_description ?? ""}
        set { place_description = newValue}
    }
    var placeImageURL: String {
        get { place_image_URL?.absoluteString ?? "" }
        set { place_image_URL = URL.init(string: newValue)}
    }
}
