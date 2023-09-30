//
//  IOS_Advanced_Assignment_3App.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 26/09/23.
//

import SwiftUI

@main
struct IOS_Advanced_Assignment_3App: App {
    
    @StateObject private var activityModelData = ActivityModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(activityModelData)
        }
    }
}
