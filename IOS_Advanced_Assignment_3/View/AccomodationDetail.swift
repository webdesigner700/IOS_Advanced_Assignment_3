//
//  AccomodationDetail.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 03/10/23.
//

import SwiftUI

struct AccomodationDetail: View {
    
    // The shared ModelData instance which was passed to the environment on line 21 in IOS_Advanced_3App SwiftUI
    @EnvironmentObject var modelData: ModelData
    
    // A property is declared for the accomodation whose details we want to show.
    var accomodation: Accomodation
    
    
    // A computed property called "accomodationIndex" is defined of type Int? (optional integer). Optional integer indicates that the variable can either hold an integer value or a nil value
    var accomodationIndex: Int? {
        
        
        // This line attempts to find the index of an "Accomodation" object with a specific id in the "modelData.Accomodations" array. The method firstIndex(where:) iterates through the array and returns the index of the first element that satisfies the given predicate (closure).
        if let index = modelData.Accomodations.firstIndex(where: {$0.id == accomodation.id}) {
            return index
        }
        else {
            
            // The else case handles the case where no match for the index is found
            return nil
        }
    }
    
    var body: some View {
        
        
        VStack {
            
            // Display the image of the accomodation.
            accomodation.image
                .resizable()
                .frame(height: 250)
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
            
            VStack {
                
                // Display the name of the accomodation.
                Text(accomodation.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.vertical, 5)
                
                HStack {
                    
                    // Display the city and the price of the accomodation.
                    Text(accomodation.city)
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("$ \(accomodation.price)")
                        .font(.headline)
                }
                .padding(.horizontal, 16)
            }
            
            // Display the star rating of the accomodation using a horizontal stack.
            HStack {
                ForEach(1..<6) { index in
                    Image(systemName: index <= Int(accomodation.rating) ? "star.fill" : "star")
                        .foregroundColor(index <= Int(accomodation.rating) ? .yellow : .gray)
                }
            }
            .padding(.bottom, 16.0)
            
            Button(action: {
                modelData.Accomodations[accomodationIndex ?? 0].inFavorites.toggle()
            }) {
                Image(systemName: modelData.Accomodations[accomodationIndex ?? 0].inFavorites ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 44, height: 44)
                    .foregroundColor(modelData.Accomodations[accomodationIndex ?? 0].inFavorites ? .red : .gray)
            }
            
            Spacer()
            
        }
    }
}


struct AccomodationDetail_Previews: PreviewProvider {
    
    // Create an instance of ModelData for the preview.
    static let modelData = ModelData()
    
    // Generate the preview by injecting the ModelData instance into the environment.
    static var previews: some View {
        AccomodationDetail(accomodation: modelData.Accomodations[0])
            .environmentObject(modelData)
    }
}
