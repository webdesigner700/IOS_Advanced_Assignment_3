//
//  ViewModel.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 26/09/23.
//

import Foundation
import Combine
import MapKit
import CoreData

final class ActivityModelData: ObservableObject {
    
    @Published var Activities: [Activity] = load("ActivityData.json")
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: .init(latitude: -33.8837, longitude: 151.2006), span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    @Published var annotations: [ActivityAnnotation] = []
    
    //self.Activities.map { activity in ... } applies a closure to each element in the Activities array.
    //For each activity in Activities, it creates an ActivityAnnotation object by passing the activity to the ActivityAnnotation initializer.
    //The resulting array of ActivityAnnotation objects is assigned to self.annotations.
    
    init() {
        
        self.annotations = self.Activities.map{ activity in
            
            return ActivityAnnotation(activity: activity)
        }
    }
}

// The laod function loads data from a JSON file and decodes it into the specified model type

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    // Try to find the URL of the specified filename in the main bundle
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }


    do {
        // Read the contents of the file into a Data object
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }


    do {
        // Create a JSON decoder and decode the Data into the specified generic type T.
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}


