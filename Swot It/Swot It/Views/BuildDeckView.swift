import SwiftUI

struct BuildDeckView: View {
    @EnvironmentObject private var model: SwotItModel
    @State private var topic: String = ""
    @State private var numberOfCards: Int = 10
    @State private var scrollOffset: CGFloat = 0
    var topVStackHeight: CGFloat { headlineHeight + topicTextFieldHeight }
    let headlineHeight: CGFloat = 20
    let topicTextFieldHeight: CGFloat = 100
    
    var body: some View {
        ScrollView {
            VStack {
                GeometryReader { geometry in
                    Color.clear.preference(key: ViewOffsetKey.self, value: geometry.frame(in: .named("scroll")).origin.y)
                }
                .frame(height: 0)
                
                TopicInputView(topic: $topic, headlineHeight: headlineHeight, topicTextFieldHeight: topicTextFieldHeight)
                
                GenerateCardsToolbar(numberOfCards: $numberOfCards, topic: $topic) {
                    Task {
                        do {
                            try await model.generateCards(for: topic, count: numberOfCards)
                        } catch {
                            print("Error generating cards: \(error)")
                        }
                    }
                }
                
                if let currentDeck = model.currentDeck, !currentDeck.cards.isEmpty {
                    ForEach(currentDeck.cards) { card in
                        CardInListView(card: card)
                            .frame(height: 200)
                    }
                } else {
                    Text("No cards generated yet")
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ViewOffsetKey.self) { value in
            scrollOffset = value
        }
        .overlay(alignment: .top) {
            GenerateCardsToolbar(numberOfCards: $numberOfCards, topic: $topic) {
                Task {
                    do {
                        try await model.generateCards(for: topic, count: numberOfCards)
                    } catch {
                        print("Error generating cards: \(error)")
                    }
                }
            }
            .opacity(overlayOpacity)
            .animation(.easeInOut, value: scrollOffset)
            .compositingGroup()
            .shadow(radius: 5)
        }
    }
    
    var overlayOpacity: Double {
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
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct GenerateCardsToolbar: View {
    @Binding var numberOfCards: Int
    @Binding var topic: String
    var generateAction: () -> Void
    
    var body: some View {
        HStack {
            Text("Cards:")
                .font(.subheadline)
            TextField("", value: $numberOfCards, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 100)
            Spacer()
            Button(action: generateAction) {
                Image(systemName: "sparkles")
                    .foregroundColor(.blue)
                    .font(.title2)
            }
        }
        .padding()
        .background(Color.white)
    }
}

struct TopicInputView: View {
    @Binding var topic: String
    let headlineHeight: CGFloat
    let topicTextFieldHeight: CGFloat
    
    var body: some View {
        VStack {
            Text("What do you want to study?")
                .font(.headline)
                .frame(height: headlineHeight)
            
            TextEditor(text: $topic)
                .frame(height: topicTextFieldHeight)
                .border(Color.gray, width: 1)
        }
    }
}

struct BuildDeckView_Previews: PreviewProvider {
    static var previews: some View {
        BuildDeckView()
            .environmentObject(SwotItModel(apiClient: APIClient()))
    }
}
