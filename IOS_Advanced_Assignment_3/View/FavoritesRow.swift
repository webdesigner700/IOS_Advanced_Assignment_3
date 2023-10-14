//
//  FavoritesRow.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 05/10/23.
//


// Create this file so that the FavoritesList View will represent each accomodation as a row of information

import SwiftUI

struct FavoritesRow: View {
    
    // The shared ModelData instance which was passed to the environment on line 21 in IOS_Advanced_3App SwiftUI
    @EnvironmentObject var modelData: ModelData
    
    // A property is declared for the accomodation that is represented as a row of information.
    var accomodation: Accomodation
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 15) {
            
            // Display the image of the accomodation.
            accomodation.image
                .resizable()
                .frame(width: 120, height: 120)
                .cornerRadius(10)
                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 10) {
                
                // Display the name of the accomodation.
                Text(accomodation.name)
                    .font(.headline)
                
                // Display the name of the city of the accomodaiton.
                Text(accomodation.city)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // This is a horizontal stack used to display the star rating of the accomodation.
                HStack(spacing: 2) {
                    ForEach(0..<Int(accomodation.rating), id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }
                .font(.caption2)
            }
            
            Spacer()
            
            // Display the price of the accomodation in green color.
            Text("$\(accomodation.price)")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.green)
                .padding(5)
                .background(RoundedRectangle(cornerRadius: 5)
                    .fill(Color.green.opacity(0.1)))
        }
        .padding([.leading, .trailing, .top], 5)
    }
}

struct FavoritesRow_Previews: PreviewProvider {
    
    // Create an instance of ModelData for the preview.
    static let modelData = ModelData()
    
    // Generate the preview by injecting the ModelData instance into the environment. 
    static var previews: some View {
        FavoritesRow(accomodation: modelData.Accomodations[0])
            .environmentObject(modelData)
    }
}
