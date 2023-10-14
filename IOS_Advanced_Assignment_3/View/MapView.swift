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
    
    // The shared ModelData instance which was passed to the environment on line 21 in IOS_Advanced_3App SwiftUI View file is accessed here.
    @EnvironmentObject var modelData: ModelData
    
    // State variable to control whether the activity map is displayed.
    @State private var activityMap = true
    
    // State variable to control whether the accomodation map is displayed.
    @State private var accomodationMap = false
    
    var body: some View {
        
        NavigationView {
            
            // Check and show the map with activity annotations.
            if (activityMap) {
                
                
                // This code shows a map with the "coordinateregion" value accessed from the ModelData class (the region is Sydney) and the annotation items on the map are accessed from the coordinate values of each activity object in the Activities array in the ModelData class.
                Map(coordinateRegion: $modelData.region, annotationItems: modelData.activityAnnotations) { item in
                    MapAnnotation(coordinate: item.coordinate) {
                        // A NavigationLink is also created for each map annotation that takes the user to the activity detail screen which shows more information about the specific activity annotation that they click on.
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
                         // When this button is pressed on, the state variable values change, and the activity and accomodation maps are toggled accordingly.
                        self.activityMap.toggle()
                        self.accomodationMap.toggle()
                        
                    }) {
                        
                        if (activityMap == true) {
                            // This is the label for the button to switch to the accomodations map.
                            HStack {
                                
                                Image(systemName: "bed.double.circle")
                                    .imageScale(.large)
                                
                                Text("Accomodations")
                            }
                        }
                        else {
                            // This is the label for the button to switch to the activities map.
                            HStack {
                                
                                Image(systemName: "figure.run.circle")
                                    .imageScale(.large)
                                
                                Text("Activities")
                            }
                        }
                    }
                )
            }
            // Based on the state variable values, the map with the accomodation annotations is shown.
            else if (accomodationMap) {
                // This code shows a map with the "coordinateregion" value accessed from the ModelData class (the region is Sydney) and the annotation items on the map are accessed from the coordinate values of each accomodation object in the Accomodations array in the ModelData class.
                Map(coordinateRegion: $modelData.region, annotationItems: modelData.accomodationAnnotations) { item in
                    MapAnnotation(coordinate: item.coordinate) {
                        // A NavigationLink is also created for each map annotation that takes the user to the accomodation detail screen which shows more information about the specific accomodation annotation that they click on.
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
                    
                    // The code below is used to show the button to the user that lets them switch between the activity and the accomodation maps. 
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
