//
//  FavoritesRow.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 05/10/23.
//


// Create this file so that the FavoritesList View will represent each accomodation as a row of information

import SwiftUI

struct FavoritesRow: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var accomodation: Accomodation
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 15) {
            
            accomodation.image
                .resizable()
                .frame(width: 120, height: 120)
                .cornerRadius(10)
                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(accomodation.name)
                    .font(.headline)
                
                Text(accomodation.city)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack(spacing: 2) {
                    ForEach(0..<Int(accomodation.rating), id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }
                .font(.caption2)
            }
            
            Spacer()
            
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
    
    static let modelData = ModelData()
    
    static var previews: some View {
        FavoritesRow(accomodation: modelData.Accomodations[0])
            .environmentObject(modelData)
    }
}
