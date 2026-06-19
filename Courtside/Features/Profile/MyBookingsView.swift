import SwiftUI

public struct MyBookingsView: View {
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
                    
                    Text("MY BOOKINGS")
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

                        let upcomingBookings = mockBookings.filter { $0.isUpcoming }
                        let pastBookings = mockBookings.filter { !$0.isUpcoming }

                        if upcomingBookings.isEmpty && pastBookings.isEmpty {
                            EmptyStateView(
                                icon: "tennis.racket",
                                title: "No bookings yet",
                                subtitle: "Reserve a court to see your matches here.",
                                actionTitle: "Reserve a Court",
                                action: {}
                            )
                        }

                        if !upcomingBookings.isEmpty {
                            VStack(alignment: .leading, spacing: 24) {
                                Text("YOUR NEXT MATCH")
                                    .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                                    .foregroundStyle(.Courtside.textSecondary)
                                    .kerning(1.5)
                                    .padding(.horizontal, 24)
                                    .padding(.top, 32)
                                
                                ForEach(upcomingBookings) { booking in
                                    BookingCardView(booking: booking)
                                        .padding(.horizontal, 24)
                                }
                            }
                        }
                        
                        if !pastBookings.isEmpty {
                            VStack(alignment: .leading, spacing: 24) {
                                Text("PAST BOOKINGS")
                                    .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                                    .foregroundStyle(.Courtside.textSecondary)
                                    .kerning(1.5)
                                    .padding(.horizontal, 24)
                                
                                ForEach(pastBookings) { booking in
                                    BookingCardView(booking: booking)
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

struct BookingCardView: View {
    let booking: BookingItem

    var body: some View {
        HStack(spacing: 0) {
            // Date Column
            VStack(spacing: 4) {
                Text(booking.month)
                    .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                    .foregroundStyle(booking.isUpcoming ? .Courtside.primary : .Courtside.textSecondary.opacity(0.6))
                    .kerning(1.5)

                Text(booking.date)
                    .font(.custom("PinyonScript-Regular", size: 32))
                    .foregroundStyle(booking.isUpcoming ? .Courtside.textPrimary : .Courtside.textSecondary.opacity(0.8))

                Text(booking.dayOfWeek)
                    .font(.custom("PlusJakartaSans-Regular", size: 10))
                    .foregroundStyle(booking.isUpcoming ? .Courtside.textSecondary : .Courtside.textSecondary.opacity(0.6))
            }
            .frame(width: 80)
            .frame(maxHeight: .infinity)
            .background(Color.Courtside.textSecondary.opacity(0.05))

            // Details Column
            VStack(alignment: .leading, spacing: 4) {
                Text(booking.courtName)
                    .font(.custom("PlusJakartaSans-Regular", size: 16))
                    .foregroundStyle(booking.isUpcoming ? .Courtside.textPrimary.opacity(0.9) : .Courtside.textSecondary.opacity(0.8))

                HStack(spacing: 6) {
                    Image(systemName: "clock")
                        .font(.system(size: 12))
                        .foregroundStyle(.Courtside.textSecondary)
                    Text(booking.time)
                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                        .foregroundStyle(.Courtside.textSecondary.opacity(0.8))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 24)
            .padding(.trailing, 24)
            .padding(.vertical, 24)
        }
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 24))
        .shadow(color: Color.black.opacity(0.04), radius: 16, y: 8)
    }
}
