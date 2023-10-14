//
//  Weather.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 04/10/23.
//

import Foundation

// I created these structs after reviewing the example JSON data that I would receive once firing off the API request on the Weather data API website.

// Represents a geographical location and its details
struct Location: Decodable {
    
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let tz_id: String
    let localtime_epoch: Int
    let localtime: String
}

// Represents the current weather condition details.
struct Condition: Decodable {
    let text: String
    let icon: String
    let code: Int
}

// Represents the current Weather details for a location.
struct CurrentWeather: Decodable {
    let last_updated_epoch: Int
    let last_updated: String
    let temp_c: Double
    let temp_f: Double
    let is_day: Int
    let condition: Condition
}

// Represents the complete weather response, containing both location details and current weather.
struct WeatherResponse: Decodable {
    let location: Location
    let current: CurrentWeather
}
