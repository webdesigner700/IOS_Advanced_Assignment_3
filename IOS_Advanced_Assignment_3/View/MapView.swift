//
//  MapView.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 30/09/23.
//

import SwiftUI
import MapKit

// now implement MapView with a map showing all the Sydney Activities

struct MapView: View {
    
    @EnvironmentObject var activityModelData: ActivityModelData
    
    var body: some View {
        
        NavigationView {
            
            Map(coordinateRegion: $activityModelData.region, annotationItems: activityModelData.annotations) { item in
                MapAnnotation(coordinate: item.coordinate) {
                    NavigationLink( destination: ActivityDetail()) {
                        Text(item.name)
                    }
                }
                
            }
            .navigationTitle("Sydney Activities")
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(ActivityModelData())
    }
}
