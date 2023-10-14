//
//  WeatherView.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 09/10/23.
//

import SwiftUI

struct WeatherView: View {
    
    // The shared ModelData instance which was passed to the environment on line 21 in IOS_Advanced_3App SwiftUI
    @EnvironmentObject var modelData: ModelData
    
    // A property to store information about the current location.
    var location: Location
    
    // A property to store the current weather details of the location.
    var currentWeather: CurrentWeather
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            // Display the name of the location.
            Text(location.name)
                .font(.largeTitle)
                .bold()
            
            HStack() {
                
                // Display the latitude and longitude of the location.
                Text("Latitude: \(location.lat)")
                Text("Longitude: \(location.lon)")
                
            }
            
            // Display the timezone ID and local time of the location.
            Text("Timezone: \(location.tz_id)")
            Text("Local Time: \(location.localtime)")
            
            Divider()
            
            // Current Weather Details
                
            VStack(alignment: .leading) {
                
                Text("Temperature:")
                    .font(.headline)
                
                // Display the current temperature in celcius and farhenhiet.
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
                
                // A horizontal stack containing buttons to select between a Dark and Light theme.
                HStack(spacing: 20) {
                    
                    // This Button sets the dark theme by setting a specific value to the UserDefaults key "SelectedTheme".
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
                        
                    // This Button sets the light theme by setting a specific value to the UserDefaults key "SelectedTheme".
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
    
    // Create an instance of "ModelData" for the preview.
    static let modelData = ModelData()
    
    // Generate the preview by injecting the ModelData instance into the environment.
    static var previews: some View {
        WeatherView(location: modelData.location, currentWeather: modelData.currentWeather)
            .environmentObject(modelData)
    }
}
