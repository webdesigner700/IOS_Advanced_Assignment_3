//
//  AccomodationList.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 03/10/23.
//

import SwiftUI

struct FavoritesList: View {
    
    // The shared ModelData instance which was passed to the environment on line 21 in IOS_Advanced_3App SwiftUI
    @EnvironmentObject var modelData: ModelData
    
    // A computed property to filter out the array of Accomodations from the ModelData class based on the inFavorites property boolean status of an Accomodation object.
    var filteredAccomodations: [Accomodation] {
        
        modelData.Accomodations.filter {
            accomodation in (accomodation.inFavorites )
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            // If the computed property "filteredAccomodations" is not empty, i.e there are some accomodations added to the Favorites list.
            if !filteredAccomodations.isEmpty {
                
                // Present each item in the filteredAccomodations array as a "FavoriteRow" View. 
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
