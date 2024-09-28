//
//  ContentView.swift
//  Swot It
//
//  Created by Michael Baldock on 27/09/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @EnvironmentObject var model: SwotItModel
    
    var body: some View {
        TabView(selection: $selectedTab) {
            BuildView()
                .tabItem {
                    Image(systemName: "hammer")
                    Text("Build")
                }
                .tag(0)
            
            DecksView()
                .tabItem {
                    Image(systemName: "rectangle.stack")
                    Text("Decks")
                }
                .tag(1)
        }
    }
}

struct BuildView: View {
    @State private var topic: String = ""
    @State private var numberOfCards: Int = 1
    
    var body: some View {
        VStack(spacing: 20) {
            Text("What do you want to learn about?")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Topic entry Multiple Lines")
                    .font(.subheadline)
                TextEditor(text: $topic)
                    .frame(height: 100)
                    .border(Color.gray, width: 1)
            }
            
            HStack {
                Text("Number of cards")
                    .font(.subheadline)
                Spacer()
                TextField("", value: $numberOfCards, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 100)
            }
            
            // Placeholder for card slots
            ForEach(0..<3) { _ in
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(height: 50)
            }
            
            HStack {
                Button(action: {
                    // Implement save functionality
                    print("Saving: \(topic), Cards: \(numberOfCards)")
                }) {
                    Text("Save It")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                
                Button(action: {
                    // Implement go swoll functionality
                    print("Fetch questions")
                }) {
                    Text("Go Swot!")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}

protocol APIClientProtocol {
    func generateCards(topic: String, count: Int) async throws -> [Card]
    func loadDecks() async throws -> [Deck]
    // Add other API methods as needed
}

class APIClient: APIClientProtocol {
    func generateCards(topic: String, count: Int) async throws -> [Card] {
        // Return 2 hardcoded card models
        return [
            Card(front: "What is the capital of France?", back: "Paris"),
            Card(front: "Who wrote 'Romeo and Juliet'?", back: "William Shakespeare")
        ]
    }
    
    func loadDecks() async throws -> [Deck] {
        // Implement API call to load decks
        // This might load from a backend or local storage
        // Return 2 hardcoded decks with cards
        return [
            Deck(topic: "History", cards: [
                Card(front: "Who was the first President of the United States?", back: "George Washington"),
                Card(front: "In which year did World War II end?", back: "1945")
            ]),
            Deck(topic: "Science", cards: [
                Card(front: "What is the chemical symbol for gold?", back: "Au"),
                Card(front: "What is the largest planet in our solar system?", back: "Jupiter")
            ])
        ]
    }
}

class SwotItModel: ObservableObject {
    @Published var decks: [Deck] = []
    @Published var currentDeck: Deck?
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func generateCards(for topic: String, count: Int) async throws {
        let cards = try await apiClient.generateCards(topic: topic, count: count)
        currentDeck = Deck(topic: topic, cards: cards)
    }
    
    func saveDeck() {
        if let deck = currentDeck {
            decks.append(deck)
            // Here you might also want to persist the deck to local storage or a backend
        }
    }
    
    func loadDecks() async throws {
        // This could load from local storage or a backend
        decks = try await apiClient.loadDecks()
    }
}

struct Card: Identifiable, Codable {
    let id: UUID
    let front: String
    let back: String
    
    init(id: UUID = UUID(), front: String, back: String) {
        self.id = id
        self.front = front
        self.back = back
    }
}

struct Deck: Identifiable, Codable {
    let id: UUID
    let topic: String
    var cards: [Card]
    
    init(id: UUID = UUID(), topic: String, cards: [Card]) {
        self.id = id
        self.topic = topic
        self.cards = cards
    }
}

struct DecksView: View {
    var body: some View {
        Text("Decks View")
        // Implement your Decks view here
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

