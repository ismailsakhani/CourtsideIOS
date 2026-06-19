import SwiftUI

public struct HeroEventCard: View {
    let event: EventItem

    public var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text("FEATURED EVENT")
                    .font(.custom("PlusJakartaSans-SemiBold", size: 10))
                    .foregroundStyle(Color.white.opacity(0.6))
                    .kerning(2)

                Spacer()

                HStack(spacing: 4) {
                    Text(event.day)
                    Text(event.month)
                }
                .font(.custom("PlusJakartaSans-Bold", size: 12))
                .foregroundStyle(.white)
            }

            Spacer()

            VStack(alignment: .leading, spacing: 16) {
                Text(event.title)
                    .font(.custom("PlusJakartaSans-Regular", size: 32))
                    .foregroundStyle(.white)
                    .lineLimit(2)

                HStack(spacing: 8) {
                    Text(event.time)
                    Text("•")
                        .foregroundStyle(Color.white.opacity(0.3))
                    Text(event.location)
                }
                .font(.custom("PlusJakartaSans-Regular", size: 14))
                .foregroundStyle(Color.white.opacity(0.8))
            }

            HStack {
                Spacer()
                Text("RSVP")
                    .font(.custom("PlusJakartaSans-Bold", size: 12))
                    .foregroundStyle(.Courtside.textPrimary)
                    .kerning(1)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .clipShape(Capsule())
            }
            .padding(.top, 16)
        }
        .padding(32)
        .frame(height: 380)
        .background(Color.Courtside.primary)
        .clipShape(.rect(cornerRadius: 24))
        .shadow(color: Color.Courtside.primary.opacity(0.2), radius: 30, x: 0, y: 15)
    }
}
