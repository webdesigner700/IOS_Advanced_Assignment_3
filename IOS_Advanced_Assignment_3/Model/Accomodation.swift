//
//  Accomodation.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 03/10/23.
//

import Foundation
import SwiftUI
import CoreLocation

struct Accomodation: Hashable, Codable, Identifiable {
    
    var id: Int
    var name: String
    var city: String
    var rating: Double
    var price: Int
    
    var imageName: String
    
    var image: Image { // The computed Image property to create an Image from the "imageName" property
        Image(imageName)
    }
    
    private var coordinates: Coordinates
    
    var accomodationCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
    
    var inFavorites: Bool
}
