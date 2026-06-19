import SwiftUI

public struct ProfileView: View {
    @State private var path = NavigationPath()
    @State private var showQRCode = false

    public init() {}

    public var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.Courtside.background.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    
                    // --- Digital Membership Card (Hero Section) ---
                    ZStack(alignment: .bottom) {
                        // Background gradient for the top half
                        LinearGradient(
                            gradient: Gradient(colors: [Color.Courtside.textPrimary, Color.Courtside.textPrimary.opacity(0.95)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 320)
                        
                        VStack(spacing: 16) {
                            // Header
                            HStack {
                                Text("MEMBERSHIP")
                                    .font(.custom("PlusJakartaSans-Regular", size: 12))
                                    .foregroundStyle(.white.opacity(0.6))
                                    .kerning(2)
                                
                                Spacer()
                                
                                Button(action: { showQRCode = true }) {
                                    Image(systemName: "qrcode")
                                        .font(.system(size: 20))
                                        .foregroundStyle(.Courtside.primary)
                                }
                            }
                            .padding(.horizontal, 24)
                            .padding(.top, 48)
                            
                            // The Card itself
                            VStack(alignment: .leading, spacing: 24) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Founder Member")
                                            .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                                            .foregroundStyle(.Courtside.primary)
                                            .textCase(.uppercase)
                                            .kerning(1.5)
                                        
                                        Text("Ismail Sakhani")
                                            .font(.custom("PlusJakartaSans-Regular", size: 28))
                                            .foregroundStyle(.white)
                                    }
                                    Spacer()
                                    
                                    // A subtle logo or emblem
                                    Text("C")
                                        .font(.custom("PinyonScript-Regular", size: 40))
                                        .foregroundStyle(.Courtside.primary.opacity(0.2))
                                }
                                
                                Spacer()
                                
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("MEMBER SINCE")
                                            .font(.custom("PlusJakartaSans-Regular", size: 10))
                                            .foregroundStyle(.white.opacity(0.5))
                                            .kerning(1)
                                        Text("2024")
                                            .font(.custom("PlusJakartaSans-Regular", size: 14))
                                            .foregroundStyle(.white)
                                    }
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .trailing, spacing: 4) {
                                        Text("ID")
                                            .font(.custom("PlusJakartaSans-Regular", size: 10))
                                            .foregroundStyle(.white.opacity(0.5))
                                            .kerning(1)
                                        Text("001 842 931")
                                            .font(.custom("PlusJakartaSans-Regular", size: 14))
                                            .foregroundStyle(.white)
                                    }
                                }
                            }
                            .padding(24)
                            .frame(height: 200)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color(red: 0.12, green: 0.12, blue: 0.12))
                                    .shadow(color: Color.black.opacity(0.2), radius: 24, y: 12)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
                            )
                            .padding(.horizontal, 24)
                            .offset(y: 40) // Overlap the transition
                        }
                    }
                    .padding(.bottom, 80) // Make room for the offset card
                    
                    // --- "My Courtside" Settings ---
                    VStack(alignment: .leading, spacing: 32) {
                        
                        SettingsGroupView(title: "ACTIVITY") {
                            SettingsRowView(icon: "tennis.racket", title: "My Bookings") {
                                path.append(ProfileDestination.myBookings)
                            }
                            SettingsRowView(icon: "cup.and.saucer", title: "Order History") {
                                path.append(ProfileDestination.orderHistory)
                            }
                            SettingsRowView(icon: "ticket", title: "Event RSVPs", showDivider: false) {
                                path.append(ProfileDestination.eventRSVPs)
                            }
                        }

                        SettingsGroupView(title: "PREFERENCES") {
                            SettingsRowView(icon: "bell", title: "Notifications", showDivider: false) {
                                path.append(ProfileDestination.notifications)
                            }
                        }

                        SettingsGroupView(title: "ACCOUNT") {
                            SettingsRowView(icon: "lock.shield", title: "Privacy Policy & T&C", showDivider: false) {
                                path.append(ProfileDestination.privacy)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    // --- Log Out Button ---
                    Button(action: {
                        path.append(ProfileDestination.manageAccount)
                    }) {
                        Text("Manage Account")
                            .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.Courtside.primary)
                            .clipShape(.rect(cornerRadius: 100))
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 48)
                    .padding(.bottom, 120) // Tab bar clearance
                }
            }
            .scrollIndicators(.hidden)
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: ProfileDestination.self) { destination in
                switch destination {
                case .myBookings: MyBookingsView()
                case .orderHistory: OrderHistoryView()
                case .eventRSVPs: EventRSVPsView()
                case .notifications: NotificationsView()
                case .privacy: PrivacyPolicyView()
                case .manageAccount: ManageAccountView()
                }
            }
        }
        .ignoresSafeArea(edges: .top)
        .sheet(isPresented: $showQRCode) {
            MembershipQRSheet()
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        }
    } // close NavigationStack
} // close body
} // close struct

// MARK: - Components

struct SettingsGroupView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                .foregroundStyle(.Courtside.textSecondary)
                .kerning(1.5)
                .padding(.leading, 8)
            
            VStack(spacing: 0) {
                content
            }
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.04), radius: 12, y: 4)
        }
    }
}

struct SettingsRowView: View {
    let icon: String
    let title: String
    var value: String? = nil
    var showDivider: Bool = true
    var action: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: { action?() }) {
                HStack(spacing: 16) {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .light))
                        .foregroundStyle(.Courtside.primary)
                        .frame(width: 24) // Fixed width to align icons
                    
                    Text(title)
                        .font(.custom("PlusJakartaSans-Regular", size: 16))
                        .foregroundStyle(.Courtside.textPrimary)
                    
                    Spacer()
                    
                    if let value = value {
                        Text(value)
                            .font(.custom("PlusJakartaSans-Regular", size: 14))
                            .foregroundStyle(.Courtside.textSecondary)
                    }
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(.Courtside.textSecondary.opacity(0.5))
                }
                .padding(20)
                .background(Color.white)
            }
            .buttonStyle(PlainButtonStyle())
            
            if showDivider {
                Divider()
                    .background(Color.Courtside.textSecondary.opacity(0.1))
                    .padding(.leading, 60) // Align with text
                    .padding(.trailing, 20)
            }
        }
    }
}
