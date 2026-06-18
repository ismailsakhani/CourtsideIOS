import SwiftUI

public struct MainTabView: View {
    @State private var selectedTab = 0
    @StateObject private var cart = BookingCart()
    @State private var showCheckout = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {

                HomeView(selectedTab: $selectedTab)
                    .tag(0)
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                
                PlayView()
                    .tag(1)
                    .tabItem {
                        Image(systemName: "tennis.racket")
                        Text("Play")
                    }
                
                LoungeView()
                    .tag(2)
                    .tabItem {
                        Image(systemName: "cup.and.saucer.fill")
                        Text("Lounge")
                    }
                
                Text("Profile")
                    .tag(3)
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
            .accentColor(.Courtside.primary)
            
            // Global Floating Checkout Pill
            if !cart.items.isEmpty {
                VStack {
                    Spacer()
                    FloatingCartPillView {
                        showCheckout = true
                    }
                    .padding(.bottom, 64) // Just above the tab bar
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.spring(response: 0.4, dampingFraction: 0.8), value: cart.items.isEmpty)
                .zIndex(1)
            }
        }
        .environmentObject(cart)
        .sheet(isPresented: $showCheckout) {
            CheckoutView()
                .environmentObject(cart)
        }
    }
}
