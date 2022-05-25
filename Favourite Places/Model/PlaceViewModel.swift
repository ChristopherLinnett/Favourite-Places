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

///non-optional ViewModel Properties for (optionals) and conversion to strings for use with views 'place_title' `place_description` `place_Image_URL` `place_latitude` `place_longitude` database attributes
extension Place {
    ///non-optional conversion of database member 'place_title'
    var placeTitle: String {
        get { place_title ?? ""}
        set { place_title = newValue
            save()
        }
    }
    ///non-optional  conversion of database member 'place_description'
    var placeDescription: String {
        get { place_description ?? ""}
        set { place_description = newValue
            save()
        }
    }
    ///non-optional Text string conversion of database URL optional  'place_image_URL`
    var placeImageURL: String {
        get { place_image_URL?.absoluteString ?? "" }
        set { guard let url = URL(string: newValue) else { return }
            place_image_URL = url
            save()
        }
    }
    ///Text string conversion of database member 'place_latitude'
    var placeLatitude: String {
        get { String(place_latitude)}
        set { guard Double(newValue) != nil else {return}
            place_latitude = Double(newValue) ?? 0
            save()
        }
    }
    ///Text string conversion of database member 'place_longitude'
    var placeLongitude: String {
        get { String(place_longitude)}
        set { guard Double(newValue) != nil else {return}
            place_longitude = Double(newValue) ?? 0
            save()
        }
    }
    ///commits values from the editable text fields to data file triggering a change of all saves. Intended to be run when exiting edit mode.
    func commitValues(title: String, imageURL: String, description: String, lat: String, lon: String) {
        if title != "" {placeTitle = title}
        if imageURL != "" {placeImageURL = imageURL}
        if description != "" {placeDescription = description}
        if lat != "" {placeLatitude = lat}
        if lon != "" {placeLongitude = lon}
    }

    ///Downloads, caches and displays an image based on a URL
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
    ///Saves data to context. Will be run any time data changes
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
    ///Takes values (latitude and longitude) and updates the those properties for the current place within the database
    func updateFromMap(latitude:Double, longitude: Double){
        placeLatitude = String(latitude)
        placeLongitude = String(longitude)
    }
}
