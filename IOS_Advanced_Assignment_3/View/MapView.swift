//
//  MapView.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 30/09/23.
//

import SwiftUI

struct MapView: View {
    
    @EnvironmentObject var activityModelData: ActivityModelData
    
    var body: some View {
        
        List(activityModelData.Activities) { Activity in
            Text(Activity.name)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(ActivityModelData())
    }
}
