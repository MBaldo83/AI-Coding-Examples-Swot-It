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
