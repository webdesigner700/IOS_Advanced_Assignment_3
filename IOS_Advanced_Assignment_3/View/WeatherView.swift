//
//  WeatherView.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 09/10/23.
//

import SwiftUI

struct WeatherView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var location: Location
    
    var currentWeather: CurrentWeather
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            Text(location.name)
                .font(.largeTitle)
                .bold()
            
            HStack() {
                
                Text("Latitude: \(location.lat)")
                Text("Longitude: \(location.lon)")
                
            }
            
            Text("Timezone: \(location.tz_id)")
            Text("Local Time: \(location.localtime)")
            
            Divider()
            
            // Current Weather Details
                
            VStack(alignment: .leading) {
                
                Text("Temperature:")
                    .font(.headline)
                
                Text("\(currentWeather.temp_c, specifier: "%.1f")°C | \(currentWeather.temp_f, specifier: "%.1f")°F")
                    .font(.title)
            }
                
            
            Text("Condition: \(currentWeather.condition.text)")
            
            Text("Last Updated: \(currentWeather.last_updated)")
                .font(.footnote)
                .foregroundColor(.gray)
            
            VStack {
                
                Text("App Theme")
                    .font(.headline)
                    .padding(.bottom, 10)
                
                HStack(spacing: 20) {
                    
                    Button(action: {
                            UserDefaults.standard.set("Dark", forKey: "SelectedTheme")
                            modelData.setSelectedTheme()
                    }) {
                        HStack {
                            Image(systemName: "moon.fill")
                                .foregroundColor(.white)
                            Text("Dark Theme")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    }
                    .frame(width: 160)
                        
                        
                    Button(action: {
                            UserDefaults.standard.set("Light", forKey: "SelectedTheme")
                            modelData.setSelectedTheme()
                    }) {
                        HStack {
                            Image(systemName: "sun.max.fill")
                                .foregroundColor(.black)
                            Text("Light Theme")
                                .foregroundColor(.black)
                        }
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.white]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 10)
                    }
                    .frame(width: 160)
                } // This bracket is for the horizontal stack containing the app theme buttons
            } // This is the bracket for the HStack containing the "App theme" heading and the dark and light theme buttons
            .padding(.vertical, 20)
            
            Spacer()
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 20)
    }
}

struct WeatherView_Previews: PreviewProvider {
    
    static let modelData = ModelData()
    
    static var previews: some View {
        WeatherView(location: modelData.location, currentWeather: modelData.currentWeather)
            .environmentObject(modelData)
    }
}
