import SwiftUI

public struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var cart = BookingCart()
    @State private var showCheckout = false

    public init() {}

    public var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                Tab("Home", systemImage: "house", value: 0) {
                    HomeView(selectedTab: $selectedTab)
                }
                Tab("Play", systemImage: "tennis.racket", value: 1) {
                    PlayView()
                }
                Tab("Lounge", systemImage: "cup.and.saucer.fill", value: 2) {
                    LoungeView()
                }
                Tab("Profile", systemImage: "person", value: 3) {
                    ProfileView()
                }
            }
            .tint(.Courtside.primary)

            if !cart.items.isEmpty {
                VStack {
                    Spacer()
                    FloatingCartPillView {
                        showCheckout = true
                    }
                    .padding(.bottom, 64)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.spring(response: 0.4, dampingFraction: 0.8), value: cart.items.isEmpty)
                .zIndex(1)
            }
        }
        .preferredColorScheme(.light)
        .environment(cart)
        .sheet(isPresented: $showCheckout) {
            CheckoutView()
                .environment(cart)
        }
    }
}
