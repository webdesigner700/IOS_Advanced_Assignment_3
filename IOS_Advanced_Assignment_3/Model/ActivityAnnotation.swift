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
    
    // Coordinates of the activity on the map.
    var coordinate: CLLocationCoordinate2D
    
    // Properties of the activity
    let id: Int
    let name: String
    let city: String
    let state: String
    let addTime: Date
    
    // Reference to the associated Activity object,
    let activity: Activity
    
    // Name of the image associated with the activity.
    let imageName: String
    
    // Computed property to fetch the corresponding image used on "imageName
    var image: Image {
        Image(imageName)
    }
    
    // initializer to create an annotation based on a given activity object.
    init(activity: Activity) {
        
        // Setting properties based on the provided "activity" object.
        id = activity.id
        
        coordinate = CLLocationCoordinate2D(latitude: activity.activityCoordinates.latitude, longitude: activity.activityCoordinates.longitude)
        
        self.name = activity.name
        self.city = activity.city
        self.state = activity.state
        self.imageName = activity.imageName
        
        // Storing the provided Activity object.
        self.activity = activity
        
        // Setting the current date and time for "addTime".
        self.addTime = Date()
    }
}
