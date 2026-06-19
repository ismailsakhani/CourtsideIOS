import SwiftUI

public struct BookingTicketCard: View {
    let booking: BookingItem

    public var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text("UPCOMING BOOKING")
                    .font(.custom("PlusJakartaSans-Regular", size: 12))
                    .foregroundStyle(.Courtside.textSecondary)
                    .kerning(1.5)

                Spacer()

                Image(systemName: "calendar")
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(.Courtside.primary)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(booking.courtName)
                    .font(.custom("PlusJakartaSans-Regular", size: 32))
                    .foregroundStyle(.Courtside.textPrimary)

                Text(booking.matchType)
                    .font(.custom("PlusJakartaSans-Regular", size: 16))
                    .foregroundStyle(.Courtside.textSecondary)
            }

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("DATE")
                        .font(.custom("PlusJakartaSans-Regular", size: 10))
                        .foregroundStyle(.Courtside.textSecondary)
                    Text("\(booking.date) \(booking.month)")
                        .font(.custom("PlusJakartaSans-Regular", size: 16))
                        .foregroundStyle(.Courtside.textPrimary)
                }

                Spacer()

                VStack(alignment: .leading, spacing: 4) {
                    Text("TIME")
                        .font(.custom("PlusJakartaSans-Regular", size: 10))
                        .foregroundStyle(.Courtside.textSecondary)
                    Text(booking.time)
                        .font(.custom("PlusJakartaSans-Regular", size: 16))
                        .foregroundStyle(.Courtside.textPrimary)
                }
            }
            .padding(.top, 8)
        }
        .padding(24)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 24))
        .shadow(color: Color.black.opacity(0.08), radius: 24, x: 0, y: 8)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.Courtside.textPrimary.opacity(0.05), lineWidth: 0.5)
        )
    }
}
