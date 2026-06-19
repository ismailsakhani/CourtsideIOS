import SwiftUI

struct EventCarouselCard: View {
    let event: EventItem

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("\(event.day) \(event.month) • \(event.time)")
                    .font(.custom("PlusJakartaSans-Regular", size: 12))
                    .foregroundStyle(.Courtside.primary)
                    .kerning(1.5)

                Text(event.title)
                    .font(.custom("PlusJakartaSans-Regular", size: 24))
                    .foregroundStyle(.Courtside.textPrimary)
                    .lineLimit(2)
            }

            Spacer()

            HStack {
                Text(event.location)
                    .font(.custom("PlusJakartaSans-Regular", size: 14))
                    .foregroundStyle(.Courtside.textSecondary)

                Spacer()

                Image(systemName: "arrow.right")
                    .font(.system(size: 16, weight: .light))
                    .foregroundStyle(.Courtside.primary)
            }
        }
        .padding(24)
        .frame(width: 260, height: 260)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 24))
        .shadow(color: Color.black.opacity(0.08), radius: 24, x: 0, y: 8)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.Courtside.textPrimary.opacity(0.05), lineWidth: 0.5)
        )
    }
}
