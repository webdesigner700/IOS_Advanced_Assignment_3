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
import SwiftUI

// This class is an Observable Object. Swift UI views can watch for changes in any of the Published properties defined in this class.
final class ModelData: ObservableObject {
    
    // The location and currentWeather properties will hold data that is received from the API request sent in the apiRequest function. The structs for holding the API data are defined in the "Weather" model file.
    @Published var location = Location(name: "", region: "", country: "", lat: 0.0, lon: 0.0, tz_id: "", localtime_epoch: 0, localtime: "")
    @Published var currentWeather = CurrentWeather(last_updated_epoch: 0, last_updated: "", temp_c: 0.0, temp_f: 0.0, is_day: 0, condition: Condition(text: "", icon: "", code: 0))
    
    // The Activities and Accomodations data from the JSON files found in the Resources folder are loaded into the published arrays "Activities" and "Accomodations" using the load function.
    @Published var Activities: [Activity] = load("ActivityData.json")
    @Published var Accomodations: [Accomodation] = load("AccomodationData.json")
    
    // This published variable region defines the default map region used in the MapView View file.
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: .init(latitude: -33.8837, longitude: 151.2006), span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    // The two published variables "activityAnnotations" and "accomodationAnnotations" are initialized to hold the map annotations for the activities and accomodations respectively
    @Published var activityAnnotations: [ActivityAnnotation] = []
    @Published var accomodationAnnotations: [AccomodationAnnotation] = []
    
    // The private var "viewContext" acts as a bridge between the SwiftUI view files and the PersistenceController Swift file. The variable "viewContext" holds the managedObjectContext derived from the PersistenceController Swift class.
    private var viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    
    // The published variable itineraryActivities will hold the activities that are added to the itineray. Whenever an activity is added or deleted from the persistent data store. the activity is also added or deleted from the itineraryActivities variable.
    @Published var itineraryActivities = Set<Activity>()
    
    // This published variable holds the value of the theme of the application. The value of the variable is defined by the enum "AppTheme" initalized below.
    @Published var selectedTheme: AppTheme = .light
    
    // This enum is created to define the available app themes.
    enum AppTheme: String, CaseIterable {
        case light = "Light"
        case dark = "Dark"
    }
    
    // Class initializer
    init() {
        
        //Initialize map annotations for each activity from the Activities array. The map function is used to convewrt each activity into an ActivityAnnotation. The ActivityAnnotation model class conforms to the MKAnnotation protocol.
        self.activityAnnotations = self.Activities.map { activity in
            
            return ActivityAnnotation(activity: activity)
        }
        
        // Similar to the ActivityAnnotation, map annotations for each accomodation is initialized from the Accomodations Array.
        self.accomodationAnnotations = self.Accomodations.map { accomodation in
            
            return AccomodationAnnotation(accomodation: accomodation)
        }
        
        // This function fetches weather information from an external API and stores the data in the published variables "location" and "currentWeather".
        apiRequest()
    }
    
    //
    func setSelectedTheme() {
        
        // Try and retreive the raw value of the saved theme from UserDefaults.
        if let savedThemeRawValue = UserDefaults.standard.string(forKey: "SelectedTheme"),
           // if the savedThemeRawValue matches one of the enum cases from "AppTheme", "savedTheme" will set to the corresponding enum case.
            let savedTheme = AppTheme(rawValue: savedThemeRawValue) {
            // If savedTheme is successfully created, there was a previously selected theme saved in UserDefaults. In this case, the "selectedTheme" published property is set to the loaded theme.
            self.selectedTheme = savedTheme
        }
        else {
            // If no theme was previously saved in UserDefaults, or if the savedTheme does not match any AppTheme enum values, the theme is set to the default light theme.
            self.selectedTheme = .light
        }
    }
    
    
    func addItineraryActivity(activity: Activity) {
        
        // Create a new ItineraryActivity instance in the context of our managedObjectContext "viewContext"
        let itineraryActivity = ItineraryActivity(context: viewContext)
        
        // The properties of the new ItineraryActivity object are set using the passed-in "activity" object.
        itineraryActivity.id = Int32(activity.id)
        itineraryActivity.name = activity.name
        itineraryActivity.city = activity.city
        itineraryActivity.state = activity.state
        itineraryActivity.addTime = Date() // Set the current date as the value of the addTime property.
        
        do {
            // Try and save the changes made in the context to the CoreData persistent store.
            try viewContext.save()
            
            // if successful, insert the activity into the published property "itineraryActivities" set
            itineraryActivities.insert(activity)
        }
        catch {
            // Print an error if the save process was unsuccessful.
            fatalError("could not add the activity to the CoreData stack \(error.localizedDescription)")
        }
    }
    
    func deleteItineraryActivity(activity: Activity) {
        
        // Create a fetch request for the "ItineraryActivity" entity
        let fetchRequest: NSFetchRequest<ItineraryActivity> = ItineraryActivity.fetchRequest()
        
        // Use a predicate to find the ItineraryActivity object with the passed in activity's id
        fetchRequest.predicate = NSPredicate(format: "id == %id", Int32(activity.id))
        
        do {
            
            // Fetch the "ItineraryActivity" objects from CoreData matching the criteria
            let fetchedResults = try viewContext.fetch(fetchRequest)
            
            // Check if an object was fetched
            if let itineraryActivityToDelete = fetchedResults.first {
                
                // Delete the fetched "ItineraryActivity" objecet from the CoreData context.
                viewContext.delete(itineraryActivityToDelete)
                
                // Try and save changes to the managedObjectContext/
                try viewContext.save()
                
                // Remove the "Activity" object passed into the function from the published property "ItineraryActivities" set.
                itineraryActivities.remove(activity)
            }
            
        }
        catch {
            // Print an error if the itineraryActivity deletion was not successful.
            fatalError("The itinerary activity has not been deleted from the Core Data Stack: \(error.localizedDescription)")
        }
        
    }
    
    func isInItinerary(activity: Activity) -> Bool {
        
        // Create a fetch request for the "ItineraryActivity" entity
        let fetchRequest: NSFetchRequest<ItineraryActivity> = ItineraryActivity.fetchRequest()
        
        // Use a predicate to find the ItineraryActivity object with the passed in activity's id
        fetchRequest.predicate = NSPredicate(format: "id == %id", Int32(activity.id))
        
        do {
            
            // Attempt to fetch the "ItineraryActivity" obejcts that match the fetch request's criteria
            let fetchedResults = try viewContext.fetch(fetchRequest)
            
            // If an "ItineraryActivity" object is successfully fetched, return true for the function.
            if fetchedResults.first != nil {
                
                return true
            }
        }
        catch {
            
            // Print an error if there was a problem in fetching the "ItineraryActivity" objects
            print("There was an error in fetching the itinerary activity \(error.localizedDescription)")
        }
        
        // Return false if the do catch block did not find the "ItineraryActivity" object.
        return false
    }
    
    func apiRequest() {
        
        //MARK: How does an API request work
        
        // First, we will create a URL object pointing to the API end point.
        // Then, we create a Request object and we pass in the URL object.
        // We also have to specify the header parameters and the body data that is required by the API for the request to be accepted
        // We set the URL object, header parameters and the body data in our Request object. Then, we will fire off the request using the URLSessionDataTask class. Finally, we capture the data from the API.
        
        
        // Create the URL first
        
        let url = NSURL(string: "https://weatherapi-com.p.rapidapi.com/current.json?q=-33.8688%2C151.2093")
        // This let object is of optional type
        
        guard url != nil else {
            print("Error in creating the url object")
            return // Just returns if there is an error 
        }
        
        // Create the URL Request object
        let request = NSMutableURLRequest(url: url! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        //Specify the header
        let headers = [
            "X-RapidAPI-Key": "b1f523f66emsh280ccce44fa7a0dp1c29cdjsn0117ee6d5b7b",
            "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
        ]
        
        request.allHTTPHeaderFields = headers
        
        // Set the request type
        
        request.httpMethod = "GET"
        
        // Get the URL Session
        
        let session = URLSession.shared
        
        // Create the data task
        
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            // Check for errors
            if error == nil, let data = data {
                
                do {
                    // Initialize a JSON Decoder.
                    let decoder = JSONDecoder()
                    // Try to decode the received data into our predefined WeatherResponse struct in the "Weather" model file
                    let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                    
                    // Define "location" and currentWeather" variables of the "Location" and "CurrentWeather" struct type. Put data into these variables using data from the weatherResponse variable.
                    let location = weatherResponse.location
                    let currentWeather = weatherResponse.current
                    
                    // Update the UI on the main thread.
                    DispatchQueue.main.async {
                        
                        // Insert data into the published variables location and currentWeather of the types "Location" and "CurrentWeather" respectively.
                        self.location = location
                        self.currentWeather = currentWeather
                    }
                    
                    print(weatherResponse)
                }
                catch {
                    // Print an error message if there was an error in decoding the API weather data.
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }
        
        // Start the data task. This sends off the API requst.
        dataTask.resume()
    }
}

// The load function loads data from a JSON file and decodes it into the specified model type

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


