//
//  ThemeModifier.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 03/10/23.
//

import Foundation
import SwiftUI

// This is a viewModifier that sets the theme of the app based on the value of the Published property "selectedTheme" from the ModelData class. The value of :selectedTheme" is defined by the UserDefaults value of the key "SelectedTheme".
struct ThemeModifier: ViewModifier {
    
    // The current color scheme environment value.
    @Environment(\.colorScheme) var colorScheme
    
    // The selected theme from the ModelData class
    var selectedTheme: ModelData.AppTheme
    
    // If the selected theme is dark, it sets the color scheme to dark. Otherwise, it sets it to light.
    func body(content: Content) -> some View {
        content.preferredColorScheme(selectedTheme == .dark ? .dark : .light)
    }
}
