import SwiftUI

@main
struct SwotItApp: App {
    @StateObject private var model = SwotItModel(apiClient: APIClient())
    
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(model)
        }
    }
}
