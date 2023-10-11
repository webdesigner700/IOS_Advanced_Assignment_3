//
//  ItineraryList.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 30/09/23.
//

import SwiftUI
import CoreData

struct ItineraryList: View {
    
    @EnvironmentObject var modelData: ModelData
    
    @Environment(\.managedObjectContext) private var viewContext // Accessing the managed object context from the environment
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ItineraryActivity.addTime, ascending: false)], // Sorting Itinerary Activities by addtime in descending order
        animation: .default)
    
    private var itineraryActivities: FetchedResults<ItineraryActivity> // Fetching the itinerary activities from CoreData
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(itineraryActivities) { activity in
                    
                    VStack(alignment: .leading) {
                        Text(activity.name ?? "")
                            .font(.headline)
                        Text(activity.city ?? "")
                            .font(.subheadline)
                    } // change how this VStack looks
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
