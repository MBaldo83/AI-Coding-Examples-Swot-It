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
    @EnvironmentObject private var model: SwotItModel
    @State private var topic: String = ""
    @State private var numberOfCards: Int = 1
    @State private var scrollOffset: CGFloat = 0
    let topVStackHeight: CGFloat = 170 // Adjust this value based on your actual VStack height
    
    var body: some View {
        GeometryReader { outerGeometry in
            ScrollView {
                VStack(spacing: 20) {
                    GeometryReader { geometry in
                        Color.clear.preference(key: ViewOffsetKey.self, value: geometry.frame(in: .named("scroll")).origin.y)
                    }
                    .frame(height: 0)
                    
                    VStack(spacing: 20) {
                        Text("What do you want to study?")
                            .font(.headline)
                        
                        TextEditor(text: $topic)
                            .frame(height: 100)
                            .border(Color.gray, width: 1)
                    }
                    .animation(.easeInOut, value: scrollOffset)
                    
                    HStack {
                        Text("Cards:")
                            .font(.subheadline)
                        TextField("", value: $numberOfCards, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 100)
                        Spacer()
                        Button("Generate Questions") {
                            Task {
                                do {
                                    try await model.generateCards(for: topic, count: numberOfCards)
                                } catch {
                                    print("Error generating cards: \(error)")
                                }
                            }
                        }
                    }
                    .background(Color.white)
                    .zIndex(1)
                    
                    if let currentDeck = model.currentDeck, !currentDeck.cards.isEmpty {
                        ForEach(currentDeck.cards) { card in
                            HStack(spacing: 8) {
                                Text(card.front)
                                    .font(.headline)
                                
                                DottedLine()
                                    .frame(width: 1)
                                    .padding(.vertical, 4)
                                
                                Text(card.back)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 8)
                        }
                        .listStyle(PlainListStyle())
                        .frame(height: 200)
                    } else {
                        Text("No cards generated yet")
                            .foregroundColor(.secondary)
                            .padding()
                    }
                }
                .padding()
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ViewOffsetKey.self) { value in
                scrollOffset = value
                print("Scroll offset: \(scrollOffset)")
            }
            .overlay(
                stickyHeader
                    .opacity(opacity)
                    .animation(.easeInOut, value: scrollOffset)
                , alignment: .top
            )
        }
    }

    var opacity: Double {
        let fadeInThreshold = -topVStackHeight
        let fullyVisibleThreshold = fadeInThreshold - 50 // Adjust this value to control fade speed
        
        if scrollOffset > fadeInThreshold {
            return 0
        } else if scrollOffset < fullyVisibleThreshold {
            return 1
        } else {
            return Double((fadeInThreshold - scrollOffset) / (fadeInThreshold - fullyVisibleThreshold))
        }
    }
    
    var stickyHeader: some View {
        HStack {
            Text("Cards:")
                .font(.subheadline)
            TextField("", value: $numberOfCards, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 100)
            Spacer()
            Button("Generate Questions") {
                Task {
                    do {
                        try await model.generateCards(for: topic, count: numberOfCards)
                    } catch {
                        print("Error generating cards: \(error)")
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .shadow(radius: 5)
    }
}

struct DottedLine: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
            }
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
            .foregroundColor(.gray)
        }
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

// struct ScrollOffsetPreferenceKey: PreferenceKey {
//     static var defaultValue: CGFloat = 0
//     static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
//         value = nextValue()
//     }
// }

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
            Card(front: "Who wrote 'Romeo and Juliet'?", back: "William Shakespeare"),
            Card(front: "What is the largest ocean on Earth?", back: "Pacific Ocean"),
            Card(front: "Who painted the Mona Lisa?", back: "Leonardo da Vinci"),
            Card(front: "What is the chemical symbol for water?", back: "H2O"),
            Card(front: "In which year did Christopher Columbus reach the Americas?", back: "1492"),
            Card(front: "What is the largest planet in our solar system?", back: "Jupiter"),
            Card(front: "Who developed the theory of relativity?", back: "Albert Einstein"),
            Card(front: "What is the capital of Japan?", back: "Tokyo"),
            Card(front: "Who wrote '1984'?", back: "George Orwell")
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

@MainActor
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

