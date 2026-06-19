import SwiftUI

public struct LoungeView: View {
    @Environment(BookingCart.self) private var cart
    @State private var selectedDish: MenuItem?
    @State private var selectedEvent: EventItem?

    public init() {}

    public var body: some View {
        NavigationStack {
            ZStack {
                Color.Courtside.background.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 48) {

                        // Section A: The Optimist Cafe
                        VStack(alignment: .leading, spacing: 48) {

                            // Hero Logo & Description
                            VStack(spacing: 16) {
                                if let heroImage = UIImage(named: "lounge_hero.png") ?? UIImage(named: "lounge_hero") {
                                    Image(uiImage: heroImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 64)
                                        .padding(.horizontal, 40)
                                } else {
                                    Text("The Optimist")
                                        .font(.Courtside.heroDisplay)
                                        .foregroundStyle(.Courtside.textPrimary)
                                }

                                Text("Courtside recovery, specialty coffee, and organic nutrition.")
                                    .font(.custom("PlusJakartaSans-Italic", size: 16))
                                    .foregroundStyle(.Courtside.textSecondary)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 48)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 56) // Account for safe area

                            // Fine Dining Menu
                            VStack(alignment: .leading, spacing: 32) {
                                let featuredItems = loungeFeatureItems
                                ForEach(featuredItems) { item in
                                    MenuRowView(
                                        title: item.title,
                                        description: item.description,
                                        price: item.price,
                                        onRowTapped: { selectedDish = item }
                                    ) {
                                        selectedDish = item
                                    }
                                }

                                NavigationLink(value: ContentDestination.fullMenu) {
                                    HStack(spacing: 8) {
                                        Text("View full menu")
                                            .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                                        Image(systemName: "arrow.right")
                                            .font(.system(size: 12, weight: .bold))
                                    }
                                    .foregroundStyle(.Courtside.primary)
                                    .padding(.top, 8)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                            .padding(.horizontal, 24)
                        }

                        Divider()
                            .padding(.horizontal, 24)

                        // Section B: Club Events
                        VStack(alignment: .leading, spacing: 0) {
                            Text("UPCOMING EVENTS")
                                .font(.custom("PlusJakartaSans-Regular", size: 14))
                                .foregroundStyle(.Courtside.textSecondary)
                                .kerning(2)
                                .padding(.horizontal, 24)
                                .padding(.top, 48)
                                .padding(.bottom, 32)

                            VStack(spacing: 0) {
                                ForEach(allEventsData[0].events) { event in
                                    EventListRow(event: event) {
                                        selectedEvent = event
                                    }
                                }

                                NavigationLink(value: ContentDestination.allEvents) {
                                    HStack(spacing: 8) {
                                        Text("View all events")
                                            .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                                        Image(systemName: "arrow.right")
                                            .font(.system(size: 12, weight: .bold))
                                    }
                                    .foregroundStyle(.Courtside.primary)
                                    .padding(.top, 32)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                            .padding(.bottom, 120) // Give plenty of room for global checkout pill
                        }
                        .background(Color.Courtside.textSecondary.opacity(0.04))
                    }
                }
                .scrollIndicators(.hidden)
                .ignoresSafeArea(edges: .top)
            }
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: ContentDestination.self) { destination in
                switch destination {
                case .allEvents: AllEventsView()
                case .fullMenu: FullMenuView()
                }
            }
        }
        .sheet(item: $selectedDish) { dish in
            DishDetailSheet(dish: dish) {
                withAnimation { cart.add(.foodItem(dish, quantity: 1)) }
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
        .sheet(item: $selectedEvent) { event in
            EventDetailSheet(event: event)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        }
    }

}
