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
                    NavigationLink( destination: ActivityDetail(activity: item.activity)) {
                        VStack {
                            item.image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 44, height: 44)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                            Text(item.name)
                                .font(.caption)
                                .bold()
                                .foregroundColor(.primary)
                                .padding(.horizontal, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.8)) // Semi-transparent white background
                                )
                        }
                    }
                }
                
            }
            .navigationTitle("Sydney Activities")
            // Add task.aawait with findWithinVisibleRegion
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(ActivityModelData())
    }
}
