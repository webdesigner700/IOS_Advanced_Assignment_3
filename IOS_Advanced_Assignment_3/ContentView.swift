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
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
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
        ContentView()
            .environmentObject(ModelData())
    }
}
