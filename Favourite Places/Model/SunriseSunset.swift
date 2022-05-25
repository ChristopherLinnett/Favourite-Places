//
//  SunriseSunset.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 23/5/2022.
//

import Foundation
///A structure that holds two strings in place for the outputtiing sunrise/sunset strings
struct SunriseSunset: Codable {
    var sunrise: String
    var sunset: String
}
///A struct for storing the results of an API call on the sunrise sunset api
struct SunriseSunsetAPI: Codable {
    var results: SunriseSunset
}
