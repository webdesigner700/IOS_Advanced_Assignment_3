//
//  ThemeModifier.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 03/10/23.
//

import Foundation
import SwiftUI

struct ThemeModifier: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme
    
    var selectedTheme: ModelData.AppTheme
    
    func body(content: Content) -> some View {
        content.preferredColorScheme(selectedTheme == .dark ? .dark : .light)
    }
}
