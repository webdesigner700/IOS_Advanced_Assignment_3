//
//  AccomodationList.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 03/10/23.
//

import SwiftUI

struct FavoritesList: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var filteredAccomodations: [Accomodation] {
        
        modelData.Accomodations.filter {
            accomodation in (accomodation.inFavorites )
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            if !filteredAccomodations.isEmpty {
                
                List(filteredAccomodations) {
                    accomodation in
                    FavoritesRow(accomodation: accomodation)
                }
                .navigationTitle("Favourites")
            }
            else {
                
                Text("No Favorite Accomodations to display")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
                    .navigationBarTitle("Favourites")
            }

        }
    }
}

struct FavoritesList_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesList()
            .environmentObject(ModelData())
    }
}