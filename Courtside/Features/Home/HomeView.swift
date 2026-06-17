import SwiftUI

public struct HomeView: View {
    @State private var showUpdates = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            Color.Courtside.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Fixed Top Navigation
                HStack {
                    Text("C")
                        .font(.Courtside.logo)
                        .foregroundColor(.Courtside.textPrimary)
                    
                    Spacer()
                    
                    Button(action: {
                        showUpdates = true
                    }) {
                        Image(systemName: "bell")
                            .font(.system(size: 24, weight: .light))
                            .foregroundColor(.Courtside.textPrimary)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)
                .padding(.bottom, 24)
                
                // Scrollable Content
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        // Top Half: Concierge
                        VStack(alignment: .leading, spacing: 32) {
                            
                            // The Greeting
                            Text("Good evening, Aryan.")
                                .font(.Courtside.heroDisplay)
                                .foregroundColor(.Courtside.textPrimary)
                            
                            // The Primary Action
                            PrimaryButton(title: "Reserve a Court") {
                                // Action
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
                                    Text("View All")
                                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                                        .foregroundColor(.Courtside.textPrimary)
                                }
                                .padding(.horizontal, 24)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 24) {
                                        EventCarouselCard(
                                            title: "Summer Solstice Mixer",
                                            date: "FRI, 20 JUN • 7:00 PM",
                                            location: "Lounge Area"
                                        )
                                        
                                        EventCarouselCard(
                                            title: "Pro Exhibition Match",
                                            date: "SAT, 21 JUN • 5:00 PM",
                                            location: "Center Court"
                                        )
                                        
                                        EventCarouselCard(
                                            title: "Beginner's Clinic",
                                            date: "SUN, 22 JUN • 9:00 AM",
                                            location: "Court 1 & 2"
                                        )
                                    }
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 32) // Give shadows room to breathe
                                }
                            }
                        }
                        .padding(.bottom, 80)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showUpdates) {
            UpdatesView()
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

public struct EventCarouselCard: View {
    let title: String
    let date: String
    let location: String
    
    public init(title: String, date: String, location: String) {
        self.title = title
        self.date = date
        self.location = location
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text(date)
                    .font(.custom("PlusJakartaSans-Regular", size: 12))
                    .foregroundColor(.Courtside.primary)
                    .kerning(1.5)
                
                Text(title)
                    .font(.custom("PlusJakartaSans-Regular", size: 24))
                    .foregroundColor(.Courtside.textPrimary)
                    .lineLimit(2)
            }
            
            Spacer()
            
            HStack {
                Text(location)
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
