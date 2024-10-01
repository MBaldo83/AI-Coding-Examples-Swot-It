//
//  ContentView.swift
//  Swot-It-Image-To-SwiftUI
//
//  Created by Michael Baldock on 01/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var topicEntry = ""
    @State private var numberOfCards = ""
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // Sticky Header
            VStack(spacing: 10) {
                Text("What do you want to learn about?")
                    .font(.headline)
                
                TextEditor(text: $topicEntry)
                    .frame(height: 60)
                    .border(Color.gray, width: 1)
                
                HStack {
                    Text("number of cards:")
                    TextField("", text: $numberOfCards)
                        .frame(width: 50)
                        .border(Color.gray, width: 1)
                    Button("Go") {
                        // Action for Go button
                    }
                    .padding(.horizontal)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                }
            }
            .padding()
            .background(Color.white)
            
            // Vertical Scrolling List of cards
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(0..<5) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .frame(height: 100)
                            .shadow(radius: 2)
                    }
                }
                .padding()
            }
            
            // Tab Bar with 2 tabs
            TabView(selection: $selectedTab) {
                Text("Build")
                    .tabItem {
                        Text("Build")
                    }
                    .tag(0)
                
                Text("Decks")
                    .tabItem {
                        Text("Decks")
                    }
                    .tag(1)
            }
        }
        .background(Color.gray.opacity(0.1))
    }
}

#Preview {
    ContentView()
}
