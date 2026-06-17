import SwiftUI

public struct MainTabView: View {
    public init() {}
    
    public var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            Text("Play")
                .tabItem {
                    Image(systemName: "tennis.racket")
                    Text("Play")
                }
            
            Text("Community")
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Community")
                }
            
            Text("Profile")
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .accentColor(.Courtside.primary)
    }
}
