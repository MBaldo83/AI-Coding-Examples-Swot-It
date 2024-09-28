//
//  Swot_ItApp.swift
//  Swot It
//
//  Created by Michael Baldock on 27/09/2024.
//

import SwiftUI

@main
struct SwotItApp: App {
    @StateObject private var model = SwotItModel(apiClient: APIClient())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
