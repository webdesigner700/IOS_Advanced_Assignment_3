//
//  AccomodationDetail.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 03/10/23.
//

import SwiftUI

struct AccomodationDetail: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var accomodation: Accomodation
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AccomodationDetail_Previews: PreviewProvider {
    
    static let modelData = ModelData()
    
    static var previews: some View {
        AccomodationDetail(accomodation: modelData.Accomodations[0])
            .environmentObject(modelData)
    }
}
