//
//  ContentView.swift
//  Swot-It-Image-To-SwiftUI
//
//  Created by Michael Baldock on 01/10/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BuildView()
                .tabItem {
                    Label("Build", systemImage: "hammer")
                }
            DecksView()
                .tabItem {
                    Label("Decks", systemImage: "tray.full")
                }
        }
    }
}

struct BuildView: View {
    @State private var topic: String = ""
    @State private var numberOfCards: String = ""
    
    var body: some View {
        VStack {
            // Sticky Header
            VStack {
                Text("What do you want to learn about?")
                    .font(.headline)
                TextField("Topic entry", text: $topic)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 10)
                HStack {
                    Text("Number of cards:")
                    TextField("", text: $numberOfCards)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 50)
                    Button(action: {
                        // Action for Go button
                    }) {
                        Text("Go")
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            
            // Vertical Scrolling List of Cards
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(0..<4) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(UIColor.systemGray5))
                            .frame(height: 100)
                            .overlay(
                                Text("Card")
                                    .foregroundColor(.black)
                            )
                    }
                }
                .padding()
            }
        }
    }
}

struct DecksView: View {
    var body: some View {
        Text("Decks View")
    }
}

#Preview {
    ContentView()
}
