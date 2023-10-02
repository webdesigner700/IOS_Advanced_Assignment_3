//
//  IOS_Advanced_Assignment_3App.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 26/09/23.
//

import SwiftUI

@main
struct IOS_Advanced_Assignment_3App: App {
    
    let persistenceController = PersistenceController.shared
    
    //@StateObject private var dataController = DataController()
    
    @StateObject private var activityModelData = ActivityModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(activityModelData)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                //.environment(\.managedObjectContext, dataController.container.viewContext) // Sets the environment value of the specified key path to the given value. In this context. the key path leads to the managed object context and the value is the viewContext of the container initialized in the DataController class
        }
    }
}
