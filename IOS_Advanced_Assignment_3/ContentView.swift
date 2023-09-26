//
//  ContentView.swift
//  IOS_Advanced_Assignment_3
//
//  Created by vinay bayyapunedi on 26/09/23.
//

import SwiftUI
import Foundation

struct Dam: Hashable, Codable {
    
    let dam_id: Int
    let dam_name: String
}

class ViewModel: ObservableObject {
    
    @Published var dams: [Dam] = []
    
    func fetch() {
        
        let headers = [
          "authorization": "Basic YVl0b3lqUDJyY3ZhOFpkcno5dXg5R0FqVUpDSDNHMEc6OUdhNFNnVDVQakxBZE9OSg==",
          "apikey": "aYtoyjP2rcva8Zdrz9ux9GAjUJCH3G0G"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.onegov.nsw.gov.au/waternsw-waterinsights/v1/dams")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print("Error: \(error)")
            }
            else if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode == 200 {
                    
                    if let responseData = data {
                        // Decode the JSON data into Swift UI objects
                        
                        do {
                            
                            let dams = try JSONDecoder().decode([Dam].self, from: responseData)
                            DispatchQueue.main.async {
                                self.dams = dams
                            }
                        }
                        catch {
                            
                        }
                    }
                    else {
                        print("HTTP Response Code: \(httpResponse.statusCode)")
                    }
                }
            }
        })

        dataTask.resume()
    }
}

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()

    var body: some View {
        
        NavigationStack {
            List {
                ForEach(viewModel.dams, id: \.self) { dam in
                    
                    HStack {
                        Text(dam.dam_name)
                            .bold()
                    }
                }
            }
        }
        .navigationTitle("Dams")
        .onAppear {
            viewModel.fetch()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
