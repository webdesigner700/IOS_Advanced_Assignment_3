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
    
    
    // This function is used to save a station to the Itinerary
    func saveActivity(activity: Activity) {
        
        
    }
    
}
