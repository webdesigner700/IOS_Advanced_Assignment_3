//
//  Accomodation.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 03/10/23.
//

import Foundation
import SwiftUI
import CoreLocation

// This model rerepsents an Accomodation.
struct Accomodation: Hashable, Codable, Identifiable {
    
    // Various properties of the Accomodation struct.
    var id: Int
    var name: String
    var city: String
    var rating: Double
    var price: Int
    
    // The name of the image associated with the accomodation
    var imageName: String
    
    // The computed Image property to create an Image from the "imageName" property
    var image: Image {
        Image(imageName)
    }
    
    // A private property storing the latitude and longitude of the accomodation by conforming to the nested structure "Coordinates".
    private var coordinates: Coordinates
    
    // Computed property to convert the internal Coordinates structure to a Core Location's CLLocationCoordinate2D.
    var accomodationCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
    
    // A nested structure that holds the latitude and longitude values.
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
    
    // The "inFavorites" property is a boolean value that tells whether the accomodation is in the Favorites list or not. 
    var inFavorites: Bool
}
