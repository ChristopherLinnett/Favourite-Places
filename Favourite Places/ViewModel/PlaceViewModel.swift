//
//  PlaceViewModel.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 9/5/2022.
//
import CoreData
import Foundation
import SwiftUI

fileprivate let defaultImage = Image(systemName: "photo")
fileprivate var downloadedImages = [URL : Image]()

extension Place {
    ///non-optional ViewModel Properties for (optionals) 'place_title' `place_description` `place_Image_URL` database attributes
    var placeTitle: String {
        get { place_title ?? ""}
        set { place_title = newValue
            save()
        }
    }
    var placeDescription: String {
        get { place_description ?? ""}
        set { place_description = newValue
            save()
        }
    }
    var placeImageURL: String {
        get { place_image_URL?.absoluteString ?? "" }
        set { guard let url = URL(string: newValue) else { return }
            place_image_URL = url
            save()
        }
    }
    var placeLatitude: String {
        get { String(place_latitude)}
        set { guard Double(newValue) != nil else {return}
            place_latitude = Double(newValue) ?? 0
            save()
        }
    }
    var placeLongitude: String {
        get { String(place_longitude)}
        set { guard Double(newValue) != nil else {return}
            place_longitude = Double(newValue) ?? 0
            save()
        }
    }
    
    func getImage() async -> Image {
        guard let url = place_image_URL else {return defaultImage}
        if let image = downloadedImages[url] {return image}
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let uiImg = UIImage(data: data) else {return defaultImage}
            let image = Image(uiImage: uiImg).resizable()
            downloadedImages[url] = image
            return image
        } catch {
            print("Error downloading \(url): \(error.localizedDescription)")
        }
        return defaultImage
    }
    
    @discardableResult
    func save() -> Bool {
        do {
            try managedObjectContext?.save()
        } catch {
            print("Error \(error)")
            return false
        }
        return true
    }
    
    
    
}
