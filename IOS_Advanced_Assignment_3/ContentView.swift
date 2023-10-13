//
//  ContentView.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 26/09/23.
//

import SwiftUI
import Foundation
import MapKit

struct ContentView: View {
    
    // The shared ModelData instance which was passed to the environment on line 21 in IOS_Advanced_3App SwiftUI View file is accessed here
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
        // A TabView os created to show a tabbed interface to the user
        TabView() {
            
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("map")
                }
            
            ItineraryList()
                .tabItem {
                    Image(systemName: "location.circle.fill")
                    Text("Itinerary")
                }
            
            FavoritesList()
                .tabItem {
                    Image(systemName: "heart.circle")
                    Text("Favorites")
                }
    
            WeatherView(location: modelData.location, currentWeather: modelData.currentWeather)
                .tabItem {
                    Image(systemName: "cloud.circle" )
                    Text("Weather")
                }
        }
        .modifier(ThemeModifier(selectedTheme: modelData.selectedTheme))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // The ContentView is rendered with the shared ModelData instance
        ContentView()
            .environmentObject(ModelData())
    }
}
