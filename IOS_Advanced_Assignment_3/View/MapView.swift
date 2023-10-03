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
    
    // Have a Toggle Map button that switches between the Activities Map and the Accomodation Map 
    
    
    @EnvironmentObject var modelData: ModelData
    
    @State private var activityMap = true
    
    @State private var accomodationMap = false
    
    var body: some View {
        
        NavigationView {
            
            if (activityMap) {
                
                Map(coordinateRegion: $modelData.region, annotationItems: modelData.activityAnnotations) { item in
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
                .navigationBarItems(
                    
                    trailing: Button(action: {
                                
                        self.activityMap.toggle()
                        self.accomodationMap.toggle()
                        
                    }) {
                        
                        if (activityMap == true) {
                            
                            HStack {
                                
                                Image(systemName: "bed.double.circle")
                                    .imageScale(.large)
                                
                                Text("Accomodations")
                            }
                        }
                        else {
                            
                            HStack {
                                
                                Image(systemName: "figure.run.circle")
                                    .imageScale(.large)
                                
                                Text("Activities")
                            }
                        }
                    }
                )
            }
            else if (accomodationMap) {
                
                Map(coordinateRegion: $modelData.region, annotationItems: modelData.accomodationAnnotations) { item in
                    MapAnnotation(coordinate: item.coordinate) {
                        NavigationLink( destination: AccomodationDetail(accomodation: item.accomodation)) {
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
                .navigationTitle("Accomodations")
                .navigationBarItems(
                    
                    trailing: Button(action: {
                                
                        self.activityMap.toggle()
                        self.accomodationMap.toggle()
                        
                    }) {
                        
                        if (activityMap == true) {
                            Image(systemName: "bed.double.circle")
                                .imageScale(.large)
                        }
                        else {
                            Image(systemName: "figure.run.circle")
                                .imageScale(.large)
                        }
                    }
                )
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(ModelData())
            
    }
}
