import Foundation

protocol APIClientProtocol {
    func generateCards(topic: String, count: Int) async throws -> [Card]
    func loadDecks() async throws -> [Deck]
    func saveDeck(_ deck: Deck) async throws
}

class APIClient: APIClientProtocol {
    func generateCards(topic: String, count: Int) async throws -> [Card] {

        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? [String: Any],
              let apiKey = dict["OPEN_API_KEY"] as? String else {
            throw NSError(domain: "APIClientError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to load API key from Secrets.plist"])
        }
        
        print("API Key loaded successfully: \(apiKey)")

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
    
    func saveDeck(_ deck: Deck) async throws {
        // Implement the API call to save the deck
        // This is a placeholder implementation
        print("Saving deck: \(deck.topic) with \(deck.cards.count) cards")
        
        // Simulate a network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
        
        // In a real implementation, you would send the deck data to your backend
        // and handle any potential errors
    }
}
