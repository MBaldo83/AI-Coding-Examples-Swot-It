//
//  ContentView.swift
//  Swot-It-Image-To-SwiftUI
//
//  Created by Michael Baldock on 01/10/2024.
//

import SwiftUI


struct ContentView: View {
    @State private var topic: String = "The Roman republic 49 BC"
    @State private var numberOfCards: String = "10"
    
    var body: some View {
        VStack(spacing: 20) {
            Text("What do you want to learn about?")
                .font(.headline)
            
            TextField("Topic", text: $topic)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            HStack {
                Text("number of cards:")
                TextField("Number of cards", text: $numberOfCards)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 50)
                Button(action: {
                    // Action for the Go button
                }) {
                    Text("Go")
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
            }
            .padding(.horizontal)
            
            ForEach(0..<3) { _ in
                Rectangle()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    .frame(height: 50)
                    .padding(.horizontal)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
