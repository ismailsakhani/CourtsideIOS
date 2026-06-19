import SwiftUI

public struct UpdatesView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var allRead = false

    public init() {}

    public var body: some View {
        ZStack {
            Color.Courtside.background.ignoresSafeArea()

            VStack(spacing: 0) {
                // Fixed Top Navigation
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .light))
                            .foregroundStyle(.Courtside.textPrimary)
                    }

                    Spacer()

                    Button(action: {
                        withAnimation { allRead = true }
                    }) {
                        Text(allRead ? "All Read" : "Mark all read")
                            .font(.custom("PlusJakartaSans-Regular", size: 14))
                            .foregroundStyle(allRead ? .Courtside.primary : .Courtside.textSecondary)
                    }
                    .disabled(allRead)
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)
                .padding(.bottom, 24)
                
                // Scrollable Content
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        // Header
                        Text("Updates")
                            .font(.Courtside.heroDisplay)
                            .foregroundStyle(.Courtside.primary)
                            .padding(.horizontal, 24)
                            .padding(.bottom, 48)
                        
                        // Section: TODAY
                        VStack(alignment: .leading, spacing: 0) {
                            Text("TODAY")
                                .font(.custom("PlusJakartaSans-Regular", size: 12))
                                .foregroundStyle(.Courtside.textSecondary)
                                .kerning(2)
                                .padding(.horizontal, 24)
                                .padding(.bottom, 24)
                            
                            // Unread Item 1
                            UpdateCell(
                                isUnread: !allRead,
                                title: "Match Confirmed",
                                bodyText: "Padel Court 3 has been reserved for you and Michael. The concierge has been notified to prepare towels.",
                                time: "JUST NOW"
                            )

                            Divider()
                                .background(Color.Courtside.textPrimary.opacity(0.05))
                                .padding(.horizontal, 24)
                                .padding(.vertical, 24)

                            // Unread Item 2
                            UpdateCell(
                                isUnread: !allRead,
                                title: "Summer Solstice Mixer",
                                bodyText: "You are invited to an exclusive evening on the Center Court. RSVP is required to secure your attendance.",
                                time: "2 HOURS AGO"
                            )
                        }
                        .padding(.bottom, 48)
                        
                        // Section: THIS WEEK
                        VStack(alignment: .leading, spacing: 0) {
                            Text("THIS WEEK")
                                .font(.custom("PlusJakartaSans-Regular", size: 12))
                                .foregroundStyle(.Courtside.textSecondary)
                                .kerning(2)
                                .padding(.horizontal, 24)
                                .padding(.bottom, 24)
                            
                            // Read Item
                            UpdateCell(
                                isUnread: false,
                                title: "Membership Renewed",
                                bodyText: "Your monthly guest passes have been successfully refreshed.",
                                time: "TUESDAY"
                            )
                        }
                        .padding(.bottom, 80)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - Components

public struct UpdateCell: View {
    let isUnread: Bool
    let title: String
    let bodyText: String
    let time: String
    
    public init(isUnread: Bool, title: String, bodyText: String, time: String) {
        self.isUnread = isUnread
        self.title = title
        self.bodyText = bodyText
        self.time = time
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Unread Indicator
            Circle()
                .fill(isUnread ? Color.Courtside.primary : Color.clear)
                .frame(width: 8, height: 8)
                .padding(.top, 8) // Visual alignment with title
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.custom("PlusJakartaSans-Regular", size: 20))
                    .foregroundStyle(isUnread ? .Courtside.textPrimary : .Courtside.textSecondary)
                
                Text(bodyText)
                    .font(.custom("PlusJakartaSans-Regular", size: 14))
                    .foregroundStyle(.Courtside.textSecondary)
                    .lineSpacing(4)
                    .lineLimit(3)
                
                Text(time)
                    .font(.custom("PlusJakartaSans-Regular", size: 10))
                    .foregroundStyle(.Courtside.textSecondary)
                    .kerning(1.5)
                    .padding(.top, 8)
            }
            
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 24)
    }
}
