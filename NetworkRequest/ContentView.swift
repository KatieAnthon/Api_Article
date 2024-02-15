//
//  ContentView.swift
//  NetworkRequest
//
//  Created by Katie-Rose Anthonisz on 14/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var postFetcher = PostFetcher()
    let characterLimit = 100 // to track character for body
    
    @State private var isExpanded = false
    @State private var filterText = ""
    
    var filteredPosts: [Post] {
        if !filterText.isEmpty {
            return postFetcher.posts.filter { $0.title.localizedCaseInsensitiveContains(filterText)}
        } else {
            return postFetcher.posts
        }
    }
    
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Posts")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    TextField("Enter filter text", text: $filterText)
                        .padding(.horizontal)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
        
                List(filteredPosts) { post in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(post.title)
                            .font(.headline)
                            .foregroundColor(.blue)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        if isExpanded {
                            Text(post.body)
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else {
                            Text(post.body.prefix(characterLimit) + "...")
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        
                        if post.body.count > characterLimit {
                            Button(action: {
                                isExpanded.toggle()
                            }) {
                                Text(isExpanded ? "See Less" : "See More")
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    .font(.body)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            .padding()
                            
                        }
                    }
                    
                }
            }
                
            .onAppear{
                postFetcher.fetchData()
            }
            
        }
    }
}

#Preview {
    ContentView()
}

