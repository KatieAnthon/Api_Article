//
//  Services.swift
//  NetworkRequest
//
//  Created by Katie-Rose Anthonisz on 15/02/2024.
//

import SwiftUI
// use a struct to assist with decoding data

struct Post: Decodable, Identifiable {
    
    let id: Int
    let title: String
    let body: String
}


// create a get function to fetch data from the api
class PostFetcher: ObservableObject {
    @Published var posts: [Post] = []
    
    func fetchData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        var request = URLRequest(url: url)
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let data = data {
                do {
                    let decodedPosts = try JSONDecoder().decode([Post].self, from: data)
                    DispatchQueue.main.async {
                        self.posts = decodedPosts
                        print("Updated posts: \(self.posts)")}
                } catch {
                    print("Error Decoding JSON: \(error)")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        
        task.resume()
    }
}
