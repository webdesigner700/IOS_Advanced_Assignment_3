//
//  ItineraryList.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 30/09/23.
//

import SwiftUI
import CoreData

struct ItineraryList: View {
    
    // The shared ModelData instance which was passed to the environment on line 21 in IOS_Advanced_3App SwiftUI View file is accessed here.
    @EnvironmentObject var modelData: ModelData
    
    // The managedObjectContext from the PersistenceController class is accessed from the environment as it was injected into the environnment in the IOS_Advanced_Assignment_3App.
    @Environment(\.managedObjectContext) private var viewContext // Accessing the managed object context from the environment
    
    // Fetching the itinerary activities from CoreData and sorting them by the "addTime" property in descending order.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ItineraryActivity.addTime, ascending: false)], animation: .default)
    
    // Storing the fetched itineraryActivity objects in the "itineraryActivities" variable.
    private var itineraryActivities: FetchedResults<ItineraryActivity>
    
    var body: some View {
        
        NavigationView {
            List {
                // Iterating over each itinerary activity stored in the "itineraryActivities" variable to display its details.
                ForEach(itineraryActivities) { activity in
                    
                    VStack(alignment: .leading) {
                        Text(activity.name ?? "")
                            .font(.headline)
                        Text(activity.city ?? "")
                            .font(.subheadline)
                    }
                }
            }
            .navigationBarTitle("Itinerary Activities")
        }
        
    }
}

struct ItineraryList_Previews: PreviewProvider {
    static var previews: some View {
        ItineraryList()
            .environmentObject(ModelData())
    }
}
