import SwiftUI
import UserNotifications

public struct NotificationsView: View {
    @Environment(\.dismiss) private var dismiss
    
    // Toggles state
    @State private var upcomingMatches = true
    @State private var courtCancellations = true
    
    @State private var eventRSVPs = true
    
    @State private var promotionalOffers = false
    @State private var appUpdates = true
    
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
                    
                    Text("NOTIFICATIONS")
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
                        
                        SettingsGroupView(title: "BOOKINGS & PLAY") {
                            ToggleRowView(
                                title: "Upcoming Matches",
                                subtitle: "Reminders 2 hours before a booked match.",
                                isOn: $upcomingMatches
                            )
                            ToggleRowView(
                                title: "Court Cancellations",
                                subtitle: "Alerts if a court becomes unavailable.",
                                isOn: $courtCancellations,
                                showDivider: false
                            )
                        }
                        .padding(.top, 32)
                        
                        SettingsGroupView(title: "LOUNGE & EVENTS") {
                            ToggleRowView(
                                title: "Event RSVPs",
                                subtitle: "Reminders for confirmed lounge events.",
                                isOn: $eventRSVPs,
                                showDivider: false
                            )
                        }
                        
                        SettingsGroupView(title: "ACCOUNT & OFFERS") {
                            ToggleRowView(
                                title: "Promotional Offers",
                                subtitle: "Exclusive membership discounts.",
                                isOn: $promotionalOffers
                            )
                            ToggleRowView(
                                title: "App Updates",
                                subtitle: "New features and improvements.",
                                isOn: $appUpdates,
                                showDivider: false
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 64)
                }
                .scrollIndicators(.hidden)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .task {
            _ = try? await UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .badge, .sound])
        }
    }
}

struct ToggleRowView: View {
    let title: String
    let subtitle: String
    @Binding var isOn: Bool
    var showDivider: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                        .foregroundStyle(.Courtside.textPrimary)
                    
                    Text(subtitle)
                        .font(.custom("PlusJakartaSans-Regular", size: 12))
                        .foregroundStyle(.Courtside.textSecondary)
                }
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 16)
                    .fill(isOn ? Color.Courtside.primary : Color.Courtside.textSecondary.opacity(0.15))
                    .frame(width: 51, height: 31)
                    .overlay(
                        Circle()
                            .fill(Color.white)
                            .padding(2)
                            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                            .offset(x: isOn ? 10 : -10)
                    )
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isOn)
                    .onTapGesture {
                        isOn.toggle()
                    }
            }
            .padding(20)
            
            if showDivider {
                Divider()
                    .background(Color.Courtside.textSecondary.opacity(0.1))
            }
        }
    }
}
