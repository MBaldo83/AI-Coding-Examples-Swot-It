import SwiftUI

struct RootTabView: View {
    @State private var selectedTab = 0
    @EnvironmentObject var model: SwotItModel
    
    var body: some View {
        TabView(selection: $selectedTab) {
            BuildDeckView()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView()
    }
}
