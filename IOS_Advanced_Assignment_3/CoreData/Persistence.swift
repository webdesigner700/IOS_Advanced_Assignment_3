//
//  Persistence.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 02/10/23.
//

import CoreData // Import the CoreData framework


// This struct manages the persistent data storage
struct PersistenceController {
    
    
    // Singleton instance to allow global access to this controller
    static let shared = PersistenceController()
    
    // This is a preview instance using in-memory storage
    static var preview: PersistenceController = {
        
        let result = PersistenceController(inMemory: true) // Create an instance of the Persistence controller with in-memory storage
        
        // I STILL HAVE TO DEFINE THE INITIALIZER FOR THE PERSISTENCECONTROLLER STRUCT
        
        let viewContext = result.container.viewContext // Create a viewContext variable from the Persistence Controller instance
        
        for _ in 0..<10 {
            // Create 10 new Itinerary Activity objects
            let newItem = ItineraryActivity(context: viewContext)
            newItem.addTime = Date() // Set the add time to the current date
        }
        
        do {
            try viewContext.save()
        }
        catch {
            
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result // Return the instance for the preview
    }()
    
    let container: NSPersistentContainer // this is the Main persistent container
    
    init(inMemory: Bool = false) {
        
        container = NSPersistentContainer(name: "ItineraryActivities") // Initliaze the persistence container with the Data model name
        
        if (inMemory) {
        
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            // Handle error during store loading
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true // Automatically merge changes from parent context
    }
    
    
    // This function is used to save an activity to the Itinerary
    func saveActivity(activity: Activity) {
        
        let context = container.viewContext // Get the view context
        let itineraryActivity = ItineraryActivity(context: context)
        itineraryActivity.id = Int32(activity.id)
        itineraryActivity.name = activity.name
        itineraryActivity.city = activity.city
        itineraryActivity.state = activity.state
        
        do {
            try context.save() // Save changes to the context
        }
        catch {
            print("Error saving Itinerary activity \(error)") // Print the error if saving the itinerary activity is unsuccessful
        }
    }
    
    // This function is used to delete an activity from the Itinerary
    func deleteActivity(activity: Activity) {
        
        let context = container.viewContext // Get the view Context
        let fetchRequest: NSFetchRequest<ItineraryActivity> = ItineraryActivity.fetchRequest() // create a fetch request
        fetchRequest.predicate = NSPredicate(format: "id = %d", activity.id) // Add a predicate to filter the activities in the CoreData stack by the activity id
        
        do {
            let itineraryActivities = try context.fetch(fetchRequest) // Fetch all the itinerary activities
            if let itineraryActivity = itineraryActivities.first {
                context.delete(itineraryActivity) // Delete the found activity
                try context.save() // save changes to the context
            }
        } catch {
            print("Error deleting the itinerary activity: \(error)") // print an error if unable to delete the itinerary activity
        }
    }
    
    // This function is used to fewtch all the itinerary activities in the CoreData stack
    func fetchActivities() -> [ItineraryActivity] {
        
        let context = container.viewContext
        do {
            
            let fetchRequest: NSFetchRequest<ItineraryActivity> = ItineraryActivity.fetchRequest() // Create fetch request
            let itineraryActivities = try context.fetch(fetchRequest) // Fetch all the itinerary activities
            return itineraryActivities
        } catch {
            print("Error fetching the itinerary activities: \(error)")
        }
        return [] // Return and empty array if there is no itinerary activity
    }
    
    // This function is used to check whether an activity is in the Itinerary activities list
    func isInItinerary(activity: Activity) -> Bool {
        
        let context = container.viewContext // get the view context
        let fetchRequest: NSFetchRequest<ItineraryActivity> = ItineraryActivity.fetchRequest() // create a fetch request
        fetchRequest.predicate = NSPredicate(format: "id = %d", activity.id) // Add a predicate to filter the activities in the CoreData stack by the activity id
        
        do {
            
            let itineraryActivities = try context.fetch(fetchRequest) // Fetch all the itinerary activities
            if let itineraryActivity = itineraryActivities.first {
                return true
            }
        } catch {
            print("Error checking the itinerary activity \(error)")
        }
        return false // Returns false if the itinerary activity is not found
    }
    
}
