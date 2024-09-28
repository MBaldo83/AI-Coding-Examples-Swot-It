//
//  ContentView.swift
//  Swot It
//
//  Created by Michael Baldock on 27/09/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
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
    @State private var numberOfCards: String = ""
    
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
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Number of cards")
                    .font(.subheadline)
                TextField("", text: $numberOfCards)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
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
                    print("Going swoll!")
                }) {
                    Text("Go swoll!")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
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

