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

final class ModelData: ObservableObject {
    
    @Published var location = Location(name: "", region: "", country: "", lat: 0.0, lon: 0.0, tz_id: "", localtime_epoch: 0, localtime: "")
    
    @Published var currentWeather = CurrentWeather(last_updated_epoch: 0, last_updated: "", temp_c: 0.0, temp_f: 0.0, is_day: 0, condition: Condition(text: "", icon: "", code: 0))
    
    @Published var Activities: [Activity] = load("ActivityData.json")
    
    @Published var Accomodations: [Accomodation] = load("AccomodationData.json")
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: .init(latitude: -33.8837, longitude: 151.2006), span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    @Published var activityAnnotations: [ActivityAnnotation] = []
    
    @Published var accomodationAnnotations: [AccomodationAnnotation] = []
    
    private var viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    
    @Published var itineraryActivities = Set<Activity>()
    
    @Published var selectedTheme: AppTheme = .light
    
    enum AppTheme: String, CaseIterable {
        case light = "Light"
        case dark = "Dark"
        // Add more themes as needed
    }
    
    init() {
        
        self.activityAnnotations = self.Activities.map { activity in
            
            return ActivityAnnotation(activity: activity)
        }
        
        self.accomodationAnnotations = self.Accomodations.map { accomodation in
            
            return AccomodationAnnotation(accomodation: accomodation)
        }
        
        //apiRequest()
    }
    
    var userDefaultColorScheme: ColorScheme {
        
        if let rawTheme = UserDefaults.standard.string(forKey: "SelectedTheme") {
            let theme = ModelData.AppTheme(rawValue: rawTheme)
            switch theme {
            case .dark:
                return .dark
            case .light:
                return .light
            default : return .light
            }
            
        }
        return .light
    }
    
    func setSelectedTheme() {
        
        if let savedThemeRawValue = UserDefaults.standard.string(forKey: "SelectedTheme"),
           // if the savedThemeRawValue matches one of the enum cases from "AppTheme", savedTheme will set to teh corresponding enum case.
            let savedTheme = AppTheme(rawValue: savedThemeRawValue) {
            self.selectedTheme = savedTheme // If savedTheme is successfully created, there was a previously selected theme saved in UserDefaults. In this case, the selectedTheme property of the ModelData is set to the loaded theme.
        }
        else {
            self.selectedTheme = .light
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
        
        // Create the URL Request
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
                    let decoder = JSONDecoder()
                    let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                    
                    let location = weatherResponse.location
                    let currentWeather = weatherResponse.current
                    
                    DispatchQueue.main.async {
                        
                        self.location = location
                        self.currentWeather = currentWeather
                    }
                    
                    print(weatherResponse)
                }
                catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }
        
        // Fire off the data task
        dataTask.resume()
    }
        
        // Check for error
        
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


