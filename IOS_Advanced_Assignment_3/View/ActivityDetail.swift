//
//  ActivityDetail.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 30/09/23.
//

import SwiftUI

struct ActivityDetail: View {
    
    @Environment(\.managedObjectContext) private var viewContext // Accessing the managed object context from the environment
    
    @EnvironmentObject var activityModelData: ActivityModelData
    
    var activity: Activity
    
    var activityIndex: Int? {
    
        if let index = activityModelData.Activities.firstIndex(where: {$0.id == activity.id}) {
            return index
        }
        else {
            
            // The else case handles the case where no match for the index is found
            
            return nil
        }
        
        // This computes the index of the "activity" variable by comparing it to the activityModelData accomodation array
        
        // The closure { $0.id == activity.id} checks if the "id" property of the "activity" variable matches the id property of any of the activity elements in the activityModelData.Activities array.
        
    }
    
    var body: some View {

        VStack(spacing: 16) {
            
            activity.image
                .resizable()
                .frame(height: 250)
                .aspectRatio(contentMode: .fit)// Ensure the image fits while preserving aspect ratio
                //.ignoresSafeArea(edges: .top)
                .clipShape(Rectangle())
                .offset(y: -50)
            
            VStack {
                
                Text(activity.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.vertical, 5)
                
                HStack() {
                    
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
            
            if (activityModelData.isInItinerary(activity: activity)) {
                
                HStack {
                    Button(action: {
                        activityModelData.toggleInItinerary(activity: activity)
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
                        activityModelData.toggleInItinerary(activity: activity)
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
            

            
            Spacer()
        }
        
    }
}

struct ActivityDetail_Previews: PreviewProvider {
    
    static let activityModelData = ActivityModelData()
    
    static var previews: some View {
        ActivityDetail(activity: activityModelData.Activities[0])
            .environmentObject(activityModelData)
    }
}
