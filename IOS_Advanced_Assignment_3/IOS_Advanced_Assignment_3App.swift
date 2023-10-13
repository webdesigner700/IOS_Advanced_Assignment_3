//
//  IOS_Advanced_Assignment_3App.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 26/09/23.
//

import SwiftUI

@main
struct IOS_Advanced_Assignment_3App: App {
    
    // A single source of truth instance of ModelData is created using "@StateObject"
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            
                // Line 21 provides the ContentView and its children access to the shared ModelData instance
                .environmentObject(ModelData())
                // Line 24 provides the ContentView and its children access to the managed Object context defined in the PersistenceController class
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}
