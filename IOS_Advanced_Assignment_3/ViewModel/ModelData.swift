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
    
    private var viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    
    //@Environment(\.managedObjectContext) private var viewContext // Accessing the managed object context from the environment
    
    @Published var itineraryActivities = Set<Activity>()
    
    // The above published variable "itineraryActivities" is stored in the presistent CoreData Stack.
    
    //self.Activities.map { activity in ... } applies a closure to each element in the Activities array.
    //For each activity in Activities, it creates an ActivityAnnotation object by passing the activity to the ActivityAnnotation initializer.
    //The resulting array of ActivityAnnotation objects is assigned to self.annotations.
    
    init() {
        
        self.annotations = self.Activities.map{ activity in
            
            return ActivityAnnotation(activity: activity)
        }
    }
    
    
    // This function checks whether the Published variable "itineraryActivities" contains a specific activity or not. 
    func isInItinerary(activity: Activity) -> Bool {
        return itineraryActivities.contains(activity)
    }
    
    // When the button "Add to Itinerary" is pressed, this function is used to add or remove the activity from the published variable itineraryActivities
    func toggleInItinerary(activity: Activity) {
        
        if itineraryActivities.contains(activity) {
            itineraryActivities.remove(activity)
            setActivity(activity: activity, isInItinerary: false)
        }
        else {
            itineraryActivities.insert(activity)
            setActivity(activity: activity, isInItinerary: true)
        }
    }
    
    func setActivity(activity: Activity, isInItinerary: Bool) {
        
        if isInItinerary {
            // Add to the itinerary
            let itineraryActivity = ItineraryActivity(context: viewContext)
            itineraryActivity.id = Int32(activity.id)
            itineraryActivity.name = activity.name
            itineraryActivity.city = activity.city
            itineraryActivity.state = activity.state
            itineraryActivity.addTime = Date()
        }
        else {
            // Remove from the itinerary
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ItineraryActivity")
            fetchRequest.predicate = NSPredicate(format: "id == %d", Int32(activity.id))
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try viewContext.execute(deleteRequest)
            } catch {
                print("Error deleting the activity from the Itinerary \(error)")
            }
        }
        do {
            try viewContext.save()
        }
        catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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


