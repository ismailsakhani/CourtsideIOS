import SwiftUI

public struct EditorialEventRow: View {
    let event: EventItem

    public var body: some View {
        HStack(spacing: 24) {
            VStack(spacing: -2) {
                Text(event.day)
                    .font(.custom("PlusJakartaSans-Bold", size: 28))
                    .foregroundStyle(.Courtside.textPrimary)
                Text(event.month)
                    .font(.custom("PlusJakartaSans-SemiBold", size: 10))
                    .foregroundStyle(.Courtside.primary)
                    .kerning(1)
            }
            .frame(width: 48)

            VStack(alignment: .leading, spacing: 6) {
                Text(event.title)
                    .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                    .foregroundStyle(.Courtside.textPrimary)
                    .lineLimit(2)

                HStack(spacing: 6) {
                    Text(event.time)
                    Text("•")
                        .foregroundStyle(.Courtside.textSecondary.opacity(0.3))
                    Text(event.location)
                }
                .font(.custom("PlusJakartaSans-Regular", size: 13))
                .foregroundStyle(.Courtside.textSecondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.Courtside.textSecondary.opacity(0.3))
        }
        .padding(.vertical, 8)
    }
}
