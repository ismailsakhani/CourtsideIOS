import SwiftUI

public struct HomeView: View {
    @Binding var selectedTab: Int
    @Environment(BookingCart.self) private var cart
    @Environment(AppState.self) private var appState
    @State private var showUpdates = false
    @State private var selectedEvent: EventItem?
    @State private var selectedDish: MenuItem?

    public init(selectedTab: Binding<Int>) {
        self._selectedTab = selectedTab
    }

    private var timeGreeting: String {
        let hour = Calendar.current.component(.hour, from: .now)
        switch hour {
        case 0..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        default: return "Good evening"
        }
    }

    private var nextBooking: BookingItem? {
        mockBookings.filter { $0.isUpcoming }.first
    }

    public var body: some View {
        NavigationStack {
            ZStack {
                Color.Courtside.background.ignoresSafeArea()

                // Scrollable Content

                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {

                        // Cursive Logo (Scrolls away)
                        HStack {
                            Text("C")
                                .font(.Courtside.logo)
                                .foregroundStyle(.Courtside.textPrimary)
                            Spacer()
                        }
                        .padding(.horizontal, 24)
                        .offset(y: -52)
                        .padding(.bottom, -24)

                        // Top Half: Concierge
                        VStack(alignment: .leading, spacing: 32) {

                            // The Greeting
                            Text("\(timeGreeting), \(appState.memberFirstName).")
                                .font(.Courtside.heroDisplay)
                                .foregroundStyle(.Courtside.textPrimary)

                            // The Primary Action
                            PrimaryButton(title: "Reserve a Court") {
                                selectedTab = 1
                            }
                        }
                        .padding(.top, 8) // Moved up slightly more
                        .padding(.bottom, 64)
                        .padding(.horizontal, 24)

                        // Feed Section
                        VStack(alignment: .leading, spacing: 48) {

                            // Upcoming Booking
                            VStack(alignment: .leading, spacing: 24) {
                                Text("YOUR NEXT MATCH")
                                    .font(.custom("PlusJakartaSans-Regular", size: 14))
                                    .foregroundStyle(.Courtside.textSecondary)
                                    .kerning(2)
                                    .padding(.horizontal, 24)

                                if let booking = nextBooking {
                                    BookingTicketCard(booking: booking)
                                        .padding(.horizontal, 24)
                                }
                            }

                            // Upcoming Events Carousel
                            VStack(alignment: .leading, spacing: 24) {
                                HStack {
                                    Text("UPCOMING EVENTS")
                                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                                        .foregroundStyle(.Courtside.textSecondary)
                                        .kerning(2)
                                    Spacer()
                                    NavigationLink(value: ContentDestination.allEvents) {
                                        Text("View All")
                                            .font(.custom("PlusJakartaSans-Regular", size: 14))
                                            .foregroundStyle(.Courtside.primary)
                                    }
                                }
                                .padding(.horizontal, 24)

                                ScrollView(.horizontal) {
                                    HStack(spacing: 24) {
                                        ForEach(allEventsData[0].events) { event in
                                            Button(action: { selectedEvent = event }) {
                                                EventCarouselCard(event: event)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                    .padding(.horizontal, 24)
                                    .padding(.bottom, 32)  // shadows room below only — no gap above cards
                                }
                                .scrollIndicators(.hidden)

                                // --- Curated Menu Section ---
                                VStack(alignment: .leading, spacing: 24) {
                                    HStack {
                                        Text("CURATED TASTES")
                                            .font(.custom("PlusJakartaSans-Regular", size: 12))
                                            .foregroundStyle(.Courtside.textSecondary)
                                            .kerning(1.5)

                                        Spacer()

                                        NavigationLink(value: ContentDestination.fullMenu) {
                                            Text("View All")
                                                .font(.custom("PlusJakartaSans-Regular", size: 14))
                                                .foregroundStyle(.Courtside.primary)
                                        }
                                    }
                                    .padding(.horizontal, 24)

                                    VStack(spacing: 16) {
                                        if let firstDish = fullMenuData.first?.items.first {
                                            Button(action: { selectedDish = firstDish }) {
                                                DishSpotlightCard(dish: firstDish)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                            .padding(.horizontal, 24)
                                        }

                                        VStack(spacing: 32) {
                                            if fullMenuData.count > 0, fullMenuData[0].items.count >= 3 {
                                                ForEach(fullMenuData[0].items[1...2]) { dish in
                                                    MenuRowView(
                                                        title: dish.title,
                                                        description: dish.description,
                                                        price: dish.price,
                                                        onRowTapped: { selectedDish = dish }
                                                    ) {
                                                        selectedDish = dish
                                                    }
                                                    .padding(.horizontal, 24)
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(.top, 16)
                                // -----------------------------

                            }
                        }
                        .padding(.bottom, 120)
                    }
                }
                .scrollIndicators(.hidden)
                .background(Color.Courtside.background)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: ContentDestination.self) { destination in
                switch destination {
                case .allEvents: AllEventsView()
                case .fullMenu: FullMenuView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showUpdates = true
                    }) {
                        Image(systemName: "bell")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundStyle(.Courtside.textPrimary)
                    }
                    .tint(Color.Courtside.textPrimary)
                }
            }
        }
        .overlay(alignment: .bottom) {
            LinearGradient(colors: [.clear, Color.Courtside.background], startPoint: .top, endPoint: .bottom)
                .frame(height: 120)
                .allowsHitTesting(false)
                .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $showUpdates) {
            UpdatesView()
        }
        .sheet(item: $selectedEvent) { event in
            EventDetailSheet(event: event)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        }
        .sheet(item: $selectedDish) { dish in
            DishDetailSheet(dish: dish) {
                withAnimation { cart.add(.foodItem(dish, quantity: 1)) }
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }
}
