//
//  ContentView.swift
//  Swot-It-Prompt-And-Refine
//
//  Created by Michael Baldock on 01/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var topic = ""
    @State private var numberOfCards = ""
    @State private var generatedCards: [String] = []

    var body: some View {
        TabView {
            NavigationView {
                VStack(spacing: 20) {
                    Text("What do you want to learn about?")
                        .font(.title)
                        .multilineTextAlignment(.center)
                    
                    TextEditor(text: $topic)
                        .frame(height: 100)
                        .border(Color.gray, width: 1)
                        .padding()
                    
                    HStack {
                        Text("Number of cards:")
                        TextField("Enter number", text: $numberOfCards)
                            .keyboardType(.numberPad)
                            .frame(width: 100)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button("Generate") {
                            generateCards()
                        }
                        .disabled(topic.isEmpty || numberOfCards.isEmpty)
                    }
                    
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(generatedCards, id: \.self) { card in
                                Text(card)
                                    .padding()
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding()
                .navigationBarHidden(true)
            }
            .tabItem {
                Label("Builder", systemImage: "square.and.pencil")
            }
            
            Text("Decks View")
                .tabItem {
                    Label("Decks", systemImage: "rectangle.stack")
                }
        }
    }
    
    private func generateCards() {
        guard let count = Int(numberOfCards), count > 0 else { return }
        generatedCards = (1...count).map { "Card \($0) for \(topic)" }
    }
}

#Preview {
    ContentView()
}
