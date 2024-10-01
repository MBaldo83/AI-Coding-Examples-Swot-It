//
//  ContentView.swift
//  Swot-It-Image-To-SwiftUI
//
//  Created by Michael Baldock on 01/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var topic = ""
    @State private var numberOfCards = 10
    
    var body: some View {
        VStack(spacing: 20) {
            Text("What do you want to learn about?")
                .font(.headline)
            
            TextField("The Roman republic 49 BC", text: $topic)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            HStack {
                Text("number of cards:")
                    .font(.subheadline)
                
                TextField("10", value: $numberOfCards, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 50)
                
                Button("Go") {
                    // Action for the Go button
                    print("Go button tapped")
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(5)
            }
            
            // Placeholder for card views
            VStack(spacing: 10) {
                ForEach(0..<3) { _ in
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                        .frame(height: 100)
                }
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
