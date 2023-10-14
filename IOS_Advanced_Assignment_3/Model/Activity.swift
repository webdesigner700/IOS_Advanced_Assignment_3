//
//  Activity.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 30/09/23.
//

import Foundation
import SwiftUI
import CoreLocation

// This model rerepsents an Activity.
struct Activity: Hashable, Codable, Identifiable {
    
    // Various properties of the Activity struct.
    var id: Int
    var name: String
    var city: String
    var state: String
    var description: String
    
    // The name of the image associated with the activity
    var imageName: String
    
    // The computed Image property to create an Image from the "imageName" property
    var image: Image {
        Image(imageName)
    }
    
    // A private property storing the latitude and longitude of the activity by conforming to the nested structure "Coordinates".
    private var coordinates: Coordinates
    
    // Computed property to convert the internal Coordinates structure to a Core Location's CLLocationCoordinate2D.
    var activityCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
    
    // A nested structure that holds the latitude and longitude values.
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
