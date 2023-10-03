//
//  Preferences.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 03/10/23.
//

import SwiftUI
import UIKit

struct Preferences: View {
    
    //@Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
        NavigationView() {
            
            VStack(spacing: 20) {
                Text("App Theme")
                    .font(.largeTitle)
                    .padding()
                
                Button(action: {
                    print(UserDefaults.standard.string(forKey: "SelectedTheme") ?? "")
                    UserDefaults.standard.set("Dark", forKey: "SelectedTheme")
                    modelData.setSelectedTheme()
                    print(UserDefaults.standard.string(forKey: "SelectedTheme") ?? "")
                }) {
                    Text("Set Dark Theme")
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                
                Button(action: {
                    print(UserDefaults.standard.string(forKey: "SelectedTheme") ?? "")
                    UserDefaults.standard.set("Light", forKey: "SelectedTheme")
                    modelData.setSelectedTheme()
                    print(UserDefaults.standard.string(forKey: "SelectedTheme") ?? "")
                }) {
                    Text("Set Light Theme")
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
                
            }
            .navigationTitle("Preferences")
        }
    }
}

struct Preferences_Previews: PreviewProvider {
    static var previews: some View {
        Preferences()
    }
}
