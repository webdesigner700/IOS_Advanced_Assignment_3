//
//  AccomodationAnnotation.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 03/10/23.
//

import Foundation
import SwiftUI
import MapKit

class AccomodationAnnotation: NSObject, MKAnnotation, Identifiable {
    
    // Coordinates of the accomodation on the map.
    var coordinate: CLLocationCoordinate2D
    
    // Properties of the accomodation
    let id: Int
    let name: String
    let city: String
    let rating: Double
    let price: Int
    let inFavorites: Bool
    
    // Reference to the associated Accomodation object.
    let accomodation: Accomodation
    
    // Name of the image associated with the accomodation.
    let imageName: String
    
    // Computed property to fetch the corresponding image used on "imageName"
    var image: Image {
        Image(imageName)
    }
    
    // initializer to create an annotation based on a given acomodation object.
    init(accomodation: Accomodation) {
        
        // Setting properties based on the provided "acomodation" object.
        id = accomodation.id
        
        coordinate = CLLocationCoordinate2D(latitude: accomodation.accomodationCoordinates.latitude, longitude: accomodation.accomodationCoordinates.longitude)
        
        self.name = accomodation.name
        self.city = accomodation.city
        self.rating = accomodation.rating
        self.price = accomodation.price
        self.inFavorites = accomodation.inFavorites
        self.imageName = accomodation.imageName
        
        // Storing the provided Accomodation object.
        self.accomodation = accomodation
    }
    
}
