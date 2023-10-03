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
        
        VStack {
            Text("Select App Theme")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                print(UserDefaults.standard.string(forKey: "SelectedTheme") ?? "")
                UserDefaults.standard.set("Dark", forKey: "SelectedTheme")
                modelData.setSelectedTheme()
                print(UserDefaults.standard.string(forKey: "SelectedTheme") ?? "")
            }) {
                Text("Set Dark Theme")
            }
            
            
            Button(action: {
                print(UserDefaults.standard.string(forKey: "SelectedTheme") ?? "")
                UserDefaults.standard.set("Light", forKey: "SelectedTheme")
                modelData.setSelectedTheme()
                print(UserDefaults.standard.string(forKey: "SelectedTheme") ?? "")
            }) {
                Text("Set Light Theme")
            }
        }
    }
}

struct Preferences_Previews: PreviewProvider {
    static var previews: some View {
        Preferences()
    }
}
