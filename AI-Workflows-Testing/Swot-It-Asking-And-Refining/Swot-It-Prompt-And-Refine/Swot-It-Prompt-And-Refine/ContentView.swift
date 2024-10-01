//
//  ContentView.swift
//  Swot-It-Prompt-And-Refine
//
//  Created by Michael Baldock on 01/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var topic: String = ""
    @State private var numberOfCards: Int = 0
    @State private var cards: [String] = []

    var body: some View {
        TabView {
            VStack {
                Text("What do you want to learn about?")
                    .font(.title)
                    .padding(.top)

                TextField("Enter topic here", text: $topic)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(height: 100)

                HStack {
                    Text("Number of cards")
                    TextField("0", value: $numberOfCards, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .frame(width: 50)
                    Button(action: generateCards) {
                        Text("Generate")
                    }
                }
                .padding()

                ScrollView {
                    ForEach(cards, id: \.self) { card in
                        Text(card)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                }
                .padding()
            }
            .tabItem {
                Label("Builder", systemImage: "pencil")
            }

            Text("Decks View")
                .tabItem {
                    Label("Decks", systemImage: "tray.full")
                }
        }
    }

    private func generateCards() {
        cards = (1...numberOfCards).map { "Card \($0)" }
    }
}

#Preview {
    ContentView()
}
