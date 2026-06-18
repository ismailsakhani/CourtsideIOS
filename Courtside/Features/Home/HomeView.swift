import SwiftUI

public struct HomeView: View {
    @Binding var selectedTab: Int
    @EnvironmentObject var cart: BookingCart
    @State private var showUpdates = false
    @State private var selectedEvent: EventItem?
    @State private var selectedDish: MenuItem?
    
    public init(selectedTab: Binding<Int>) {
        self._selectedTab = selectedTab
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                Color.Courtside.background.ignoresSafeArea()
                
                // Scrollable Content

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        // Cursive Logo (Scrolls away)
                        HStack {
                            Text("C")
                                .font(.Courtside.logo)
                                .foregroundColor(.Courtside.textPrimary)
                            Spacer()
                        }
                        .padding(.horizontal, 24)
                        .offset(y: -52)
                        .padding(.bottom, -24)
                        
                        // Top Half: Concierge
                        VStack(alignment: .leading, spacing: 32) {
                            
                            // The Greeting
                            Text("Good evening, Aryan.")
                                .font(.Courtside.heroDisplay)
                                .foregroundColor(.Courtside.textPrimary)
                            
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
                                    .foregroundColor(.Courtside.textSecondary)
                                    .kerning(2)
                                    .padding(.horizontal, 24)
                                
                                BookingTicketCard()
                                    .padding(.horizontal, 24)
                            }
                            
                            // Upcoming Events Carousel
                            VStack(alignment: .leading, spacing: 24) {
                                HStack {
                                    Text("UPCOMING EVENTS")
                                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                                        .foregroundColor(.Courtside.textSecondary)
                                        .kerning(2)
                                    Spacer()
                                    NavigationLink(destination: AllEventsView()) {
                                        Text("View All")
                                            .font(.custom("PlusJakartaSans-Regular", size: 14))
                                            .foregroundColor(.Courtside.primary)
                                    }
                                }
                                .padding(.horizontal, 24)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 24) {
                                        ForEach(allEventsData[0].events) { event in
                                            Button(action: { selectedEvent = event }) {
                                                EventCarouselCard(event: event)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 32) // Give shadows room to breathe
                                }
                                
                                // --- Curated Menu Section ---
                                VStack(alignment: .leading, spacing: 24) {
                                    HStack {
                                        Text("CURATED TASTES")
                                            .font(.custom("PlusJakartaSans-Regular", size: 12))
                                            .foregroundColor(.Courtside.textSecondary)
                                            .kerning(1.5)
                                        
                                        Spacer()
                                        
                                        NavigationLink(destination: FullMenuView()) {
                                            Text("View All")
                                                .font(.custom("PlusJakartaSans-Regular", size: 14))
                                                .foregroundColor(.Courtside.primary)
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
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showUpdates = true
                    }) {
                        Image(systemName: "bell")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(.Courtside.textPrimary)
                    }
                }
            }
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
                let dummyCourt = Court(id: UUID().uuidString, name: dish.title)
                let slot = SelectedSlot(
                    date: Date(),
                    timeString: "Pre-order",
                    court: dummyCourt,
                    category: .recovery
                )
                withAnimation { cart.add(slot) }
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }
}

// MARK: - Components

public struct BookingTicketCard: View {
    public init() {}
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text("UPCOMING BOOKING")
                    .font(.custom("PlusJakartaSans-Regular", size: 12))
                    .foregroundColor(.Courtside.textSecondary)
                    .kerning(1.5)
                
                Spacer()
                
                Image(systemName: "calendar")
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(.Courtside.primary)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Padel Court 3")
                    .font(.custom("PlusJakartaSans-Regular", size: 32))
                    .foregroundColor(.Courtside.textPrimary)
                
                Text("With Michael & Sarah")
                    .font(.custom("PlusJakartaSans-Regular", size: 16))
                    .foregroundColor(.Courtside.textSecondary)
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("DATE")
                        .font(.custom("PlusJakartaSans-Regular", size: 10))
                        .foregroundColor(.Courtside.textSecondary)
                    Text("17 June")
                        .font(.custom("PlusJakartaSans-Regular", size: 16))
                        .foregroundColor(.Courtside.textPrimary)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("TIME")
                        .font(.custom("PlusJakartaSans-Regular", size: 10))
                        .foregroundColor(.Courtside.textSecondary)
                    Text("8:00 PM - 9:30 PM")
                        .font(.custom("PlusJakartaSans-Regular", size: 16))
                        .foregroundColor(.Courtside.textPrimary)
                }
            }
            .padding(.top, 8)
        }
        .padding(24)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.08), radius: 24, x: 0, y: 8)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.Courtside.textPrimary.opacity(0.05), lineWidth: 0.5)
        )
    }
}

struct EventCarouselCard: View {
    let event: EventItem
    
    init(event: EventItem) {
        self.event = event
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("\(event.day) \(event.month) • \(event.time)")
                    .font(.custom("PlusJakartaSans-Regular", size: 12))
                    .foregroundColor(.Courtside.primary)
                    .kerning(1.5)
                
                Text(event.title)
                    .font(.custom("PlusJakartaSans-Regular", size: 24))
                    .foregroundColor(.Courtside.textPrimary)
                    .lineLimit(2)
            }
            
            Spacer()
            
            HStack {
                Text(event.location)
                    .font(.custom("PlusJakartaSans-Regular", size: 14))
                    .foregroundColor(.Courtside.textSecondary)
                
                Spacer()
                
                Image(systemName: "arrow.right")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.Courtside.primary)
            }
        }
        .padding(24)
        .frame(width: 260, height: 260)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.08), radius: 24, x: 0, y: 8)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.Courtside.textPrimary.opacity(0.05), lineWidth: 0.5)
        )
    }
}

struct DishSpotlightCard: View {
    let dish: MenuItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image Placeholder
            Rectangle()
                .fill(Color.Courtside.textSecondary.opacity(0.04))
                .frame(height: 240)
                .overlay(
                    VStack(spacing: 8) {
                        Image(systemName: "photo")
                            .font(.system(size: 24))
                        Text("Chef's Pick")
                            .font(.custom("PlusJakartaSans-Bold", size: 10))
                            .kerning(1)
                    }
                    .foregroundColor(.Courtside.textSecondary.opacity(0.3))
                )
            
            // Content
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top) {
                    Text(dish.title)
                        .font(.custom("PlusJakartaSans-Regular", size: 24))
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Text(dish.price)
                        .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                        .foregroundColor(.Courtside.primary)
                }
                
                Text(dish.description ?? "")
                    .font(.custom("PlusJakartaSans-Regular", size: 14))
                    .foregroundColor(.white.opacity(0.6))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .padding(24)
            .background(Color.Courtside.primary)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: Color.black.opacity(0.15), radius: 24, y: 12)
    }
}
