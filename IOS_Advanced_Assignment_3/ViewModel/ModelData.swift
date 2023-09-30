//
//  ViewModel.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 26/09/23.
//

import Foundation
import Combine

final class ActivityModelData: ObservableObject {
    
    @Published var Activities: [Activity] = load("ActivityData.json")
}

// The laod function loads data from a JSON file and decodes it into the specified model type

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    // Try to find the URL of the specified filename in the main bundle
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }


    do {
        // Read the contents of the file into a Data object
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }


    do {
        // Create a JSON decoder and decode the Data into the specified generic type T.
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}


