//
//  Weather.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 04/10/23.
//

import Foundation

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

struct Condition: Decodable {
    let text: String
    let icon: String
    let code: Int
}

struct CurrentWeather: Decodable {
    let last_updated_epoch: Int
    let last_updated: String
    let temp_c: Double
    let temp_f: Double
    let is_day: Int
    let condition: Condition
}

struct WeatherResponse: Decodable {
    let location: Location
    let current: CurrentWeather
}
