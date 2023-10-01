//
//  Activity.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 30/09/23.
//

import Foundation
import SwiftUI
import CoreLocation

struct Activity: Hashable, Codable, Identifiable {
    
    var id: Int
    var name: String
    var city: String
    var state: String
    
    var imageName: String // The name of the image associated with the activity
    
    var image: Image { // The computed Image property to create an Image from the "imageName" property
        Image(imageName)
    }
    
    private var coordinates: Coordinates
    
    var activityCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
    
    var inItinerary: Bool
}
