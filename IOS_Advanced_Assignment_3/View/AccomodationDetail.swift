//
//  AccomodationDetail.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 03/10/23.
//

import SwiftUI

struct AccomodationDetail: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var accomodation: Accomodation
    
    
    // A computed property called "accomodationIndex" is defined of type Int? (optional integer). Optional integer indicates that the variable canm either hold an integer value or a nil value
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
            
            accomodation.image
                .resizable()
                .frame(height: 250)
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
            
            VStack {
                
                Text(accomodation.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.vertical, 5)
                
                HStack {
                    
                    Text(accomodation.city)
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("$ \(accomodation.price)")
                        .font(.headline)
                }
                .padding(.horizontal, 16)
            }
            
            HStack {
                ForEach(1..<6) { index in
                    Image(systemName: index <= Int(accomodation.rating) ? "star.fill" : "star")
                        .foregroundColor(index <= Int(accomodation.rating) ? .yellow : .gray)
                }
            }
            
            Spacer()
            
            
        }
    }
}


struct AccomodationDetail_Previews: PreviewProvider {
    
    static let modelData = ModelData()
    
    static var previews: some View {
        AccomodationDetail(accomodation: modelData.Accomodations[0])
            .environmentObject(modelData)
    }
}
