//
//  ActivityAnnotation.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 30/09/23.
//

import Foundation
import SwiftUI
import MapKit

// Conforming to the "MKAnnotation" protocol means that instances of "ActivityAnnotation" class can be used as annotations on a map (like pins) in the context of MapKit.

// This class is made decodable so that it can be initialized from the decoded JSON data

class ActivityAnnotation: NSObject, MKAnnotation, Identifiable {
    
    var coordinate: CLLocationCoordinate2D
    
    let id: Int
    let name: String
    let city: String
    let state: String
    let addTime: Date
    
    let activity: Activity
    
    let imageName: String
    
    var image: Image { // "image" is a computed property which means it is read-only
        Image(imageName)
    }
    
    init(activity: Activity) {
        
        id = activity.id
        
        coordinate = CLLocationCoordinate2D(latitude: activity.activityCoordinates.latitude, longitude: activity.activityCoordinates.longitude)
        
        self.name = activity.name
        self.city = activity.city
        self.state = activity.state
        self.imageName = activity.imageName
        
        self.activity = activity
        
        self.addTime = Date()
    }
}
