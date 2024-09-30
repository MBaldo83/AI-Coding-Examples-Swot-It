import Foundation

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
    
    func saveDeck() async throws {
        if let deck = currentDeck {
            try await apiClient.saveDeck(deck)
            decks.append(deck)
            // Optionally, you might want to reset the currentDeck after saving
            // currentDeck = nil
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
