//
//  ContentView.swift
//  Swot-It-Prompt-And-Refine
//
//  Created by Michael Baldock on 01/10/2024.
//

import SwiftUI

struct DecksView: View {
    var body: some View {
        Text("Decks View")
            .font(.largeTitle)
            .padding()
    }
}

struct RootView: View {
    var body: some View {
        TabView {
            BuilderView()
                .tabItem {
                    Label("Builder", systemImage: "pencil")
                }
            
            DecksView()
                .tabItem {
                    Label("Decks", systemImage: "tray.full")
                }
        }
    }
}

struct BuilderView: View {
    @State private var topic: String = ""
    @State private var numberOfCards: Int = 0
    @State private var cards: [String] = [] // Placeholder for generated cards

    var body: some View {
        VStack {
            Text("What do you want to learn about?")
                .font(.title)
                .padding()
            
            TextField("Enter topic here", text: $topic)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                Text("Number of cards")
                TextField("0", value: $numberOfCards, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 50)
                Button(action: {
                    // Action to generate cards
                    // For now, we'll just create dummy cards
                    cards = (1...numberOfCards).map { "Card \($0)" }
                }) {
                    Text("Generate Cards")
                }
            }
            .padding()
            
            ScrollView {
                LazyVStack {
                    ForEach(cards, id: \.self) { card in
                        Text(card)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .padding(.bottom, 5)
                    }
                }
                .padding()
            }
            
            // Add more UI elements here as needed
        }
    }
}
