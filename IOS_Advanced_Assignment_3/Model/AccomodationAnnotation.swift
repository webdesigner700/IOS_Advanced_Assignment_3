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
    
    var coordinate: CLLocationCoordinate2D
    
    let id: Int
    let name: String
    let city: String
    let rating: Double
    let price: Int
    let inFavorites: Bool
    
    let accomodation: Accomodation
    
    let imageName: String
    
    var image: Image {
        Image(imageName)
    }
    
    init(accomodation: Accomodation) {
        
        id = accomodation.id
        
        coordinate = CLLocationCoordinate2D(latitude: accomodation.accomodationCoordinates.latitude, longitude: accomodation.accomodationCoordinates.longitude)
        
        self.name = accomodation.name
        self.city = accomodation.city
        self.rating = accomodation.rating
        self.price = accomodation.price
        self.inFavorites = accomodation.inFavorites
        self.imageName = accomodation.imageName
        
        self.accomodation = accomodation
    }
    
}
