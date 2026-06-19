import SwiftUI

public struct EventRSVPsView: View {
    @Environment(\.dismiss) private var dismiss
    
    public init() {}
    
    public var body: some View {
        ZStack {
            Color.Courtside.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Custom Header
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20))
                            .foregroundStyle(.Courtside.textPrimary)
                    }
                    
                    Spacer()
                    
                    Text("EVENT RSVPs")
                        .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                        .foregroundStyle(.Courtside.textPrimary)
                        .kerning(1.5)
                    
                    Spacer()
                    
                    // Invisible placeholder to center the title
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20))
                        .opacity(0)
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 16)
                
                Divider()
                    .background(Color.Courtside.textSecondary.opacity(0.1))
                
                // Continuous Scroll Feed
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {

                        let upcomingEvents = mockRSVPs.filter { $0.isUpcoming }
                        let pastEvents = mockRSVPs.filter { !$0.isUpcoming }

                        if upcomingEvents.isEmpty && pastEvents.isEmpty {
                            EmptyStateView(
                                icon: "ticket",
                                title: "No RSVPs yet",
                                subtitle: "Discover upcoming events and secure your spot.",
                                actionTitle: "View Events",
                                action: {}
                            )
                        }

                        if !upcomingEvents.isEmpty {
                            VStack(alignment: .leading, spacing: 24) {
                                Text("YOUR UPCOMING EVENTS")
                                    .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                                    .foregroundStyle(.Courtside.textSecondary)
                                    .kerning(1.5)
                                    .padding(.horizontal, 24)
                                    .padding(.top, 32)
                                
                                ForEach(upcomingEvents) { event in
                                    EventRSVPCardView(event: event)
                                        .padding(.horizontal, 24)
                                }
                            }
                        }
                        
                        if !pastEvents.isEmpty {
                            VStack(alignment: .leading, spacing: 24) {
                                Text("PAST EVENTS")
                                    .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                                    .foregroundStyle(.Courtside.textSecondary)
                                    .kerning(1.5)
                                    .padding(.horizontal, 24)
                                
                                ForEach(pastEvents) { event in
                                    EventRSVPCardView(event: event)
                                        .padding(.horizontal, 24)
                                }
                            }
                            .padding(.top, 16)
                            .padding(.bottom, 64)
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct EventRSVPCardView: View {
    let event: EventRSVPItem
    
    var body: some View {
        VStack(spacing: 0) {
            // Image Area
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(Color.Courtside.textSecondary.opacity(0.05))
                    .frame(height: 120)
                
                Image(systemName: "photo")
                    .font(.system(size: 24))
                    .foregroundStyle(.Courtside.textSecondary.opacity(0.3))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if event.isUpcoming {
                    Text("CONFIRMED RSVP")
                        .font(.custom("PlusJakartaSans-SemiBold", size: 10))
                        .foregroundStyle(.white)
                        .kerning(1.5)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.Courtside.primary)
                        .clipShape(.rect(cornerRadius: 100))
                        .padding(16)
                }
            }
            
            // Details Area
            VStack(alignment: .leading, spacing: 16) {
                Text(event.title)
                    .font(.custom("PlusJakartaSans-Regular", size: 20))
                    .foregroundStyle(event.isUpcoming ? .Courtside.textPrimary : .Courtside.textSecondary.opacity(0.8))
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 8) {
                        Image(systemName: "calendar")
                            .font(.system(size: 14))
                            .foregroundStyle(.Courtside.textSecondary)
                            .frame(width: 16)
                        Text(event.dateStr)
                            .font(.custom("PlusJakartaSans-Regular", size: 14))
                            .foregroundStyle(event.isUpcoming ? .Courtside.textSecondary : .Courtside.textSecondary.opacity(0.6))
                    }
                    
                    HStack(spacing: 8) {
                        Image(systemName: "clock")
                            .font(.system(size: 14))
                            .foregroundStyle(.Courtside.textSecondary)
                            .frame(width: 16)
                        Text(event.timeStr)
                            .font(.custom("PlusJakartaSans-Regular", size: 14))
                            .foregroundStyle(event.isUpcoming ? .Courtside.textSecondary : .Courtside.textSecondary.opacity(0.6))
                    }
                    
                    HStack(spacing: 8) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 14))
                            .foregroundStyle(.Courtside.textSecondary)
                            .frame(width: 16)
                        Text(event.locationStr)
                            .font(.custom("PlusJakartaSans-Regular", size: 14))
                            .foregroundStyle(event.isUpcoming ? .Courtside.textSecondary : .Courtside.textSecondary.opacity(0.6))
                    }
                }

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(24)
        }
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 24))
        .shadow(color: Color.black.opacity(0.04), radius: 16, y: 8)
    }
}
