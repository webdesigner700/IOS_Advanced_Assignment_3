//
//  ActivityDetail.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 30/09/23.
//

import SwiftUI

struct ActivityDetail: View {
    
    // The shared ModelData instance which was passed to the environment on line 21 in IOS_Advanced_3App SwiftUI 
    @EnvironmentObject var modelData: ModelData

    // A property is declared for the activity whose details we want to show.
    var activity: Activity
    
    var body: some View {

        VStack(spacing: 8) {
            
            // Displays the image of the activity
            activity.image
                .resizable()
                .frame(height: 250)
                .aspectRatio(contentMode: .fit)// Ensure the image fits while preserving aspect ratio
                .clipShape(Rectangle())
                .offset(y: -50)
            
            VStack {
                // Displays the name of the activity
                Text(activity.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.vertical, 5)
                
                HStack() {
                    // Displays the city and state of the activity
                    Text(activity.city)
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(activity.state)
                        .font(.headline)
                }
                .padding(.horizontal, 16)
            }
            .offset(y: -50)
            .padding(.horizontal, 16)
            
            Divider()
                .offset(y: -50)
            
            // Conditionally display the "Remove from Itinerary" button or "Add to Itineray" button based on whether the activity is present in the persistent data storage or not. The isInItinerary function creates a fetch request and check whether the ativity in the parameter of the function is present in the persistent data storage or not.
            
            if (modelData.isInItinerary(activity: activity)) {
                
                HStack {
                    Button(action: {
                        // If the actiivty is in the itinerary, the button shown to the user will delete the activity from the itinerary if clicked on it.
                        modelData.deleteItineraryActivity(activity: activity)
                    }) {
                        HStack {
                            Image(systemName: "minus.circle")
                            
                            Text("Remove from Itinerary")
                                .fontWeight(.semibold)
                                .font(.title2)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .frame(height: 40.0)
                    .fontWeight(.semibold)
                    .font(.title2)
                }
                .background(
                    Rectangle()
                        .stroke(Color.blue, lineWidth: 2) // Adjust color and line width as needed
                )
                .offset(y: -50)

                
            }
            
            else {
                
                HStack {
                    Button(action: {
                        // If the actiivty is not in the activity, the button shown to the user will add the activity to the itinerary if clicked on it.
                        modelData.addItineraryActivity(activity: activity)
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                            
                            Text("Add to Itinerary")
                                .fontWeight(.semibold)
                                .font(.title2)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .frame(height: 40.0)
                    .fontWeight(.semibold)
                    .font(.title2)
                }
                .background(
                    Rectangle()
                        .stroke(Color.blue, lineWidth: 2) // Adjust color and line width as needed
                )
                .offset(y: -50)
                
            }
            
            Divider()
            
            Text("Description")
                .font(.headline)
                .offset(y: -30)
            
            Text(activity.description)
                .offset(y: -30)
                .padding(.horizontal, 8)
            
            Spacer()
        }
    }
}

struct ActivityDetail_Previews: PreviewProvider {
    
    // Create an instance of ModelData for the preview.
    
    static let modelData = ModelData()
    
    // Generate the preview with modeData as an environment Object.
    static var previews: some View {
        ActivityDetail(activity: modelData.Activities[0])
            .environmentObject(modelData)
    }
}
