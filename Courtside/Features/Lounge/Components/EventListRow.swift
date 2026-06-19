import SwiftUI

public struct EventListRow: View {
    let event: EventItem
    let onRowTapped: () -> Void

    public var body: some View {
        Button(action: onRowTapped) {
            VStack(spacing: 0) {
                HStack(alignment: .top, spacing: 24) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(event.day) \(event.month)")
                            .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                            .foregroundStyle(.Courtside.primary)
                        Text(event.time)
                            .font(.custom("PlusJakartaSans-Regular", size: 14))
                            .foregroundStyle(.Courtside.textSecondary)
                    }
                    .frame(width: 100, alignment: .leading)

                    VStack(alignment: .leading, spacing: 8) {
                        Text(event.title)
                            .font(.custom("PlusJakartaSans-Regular", size: 20))
                            .foregroundStyle(.Courtside.textPrimary)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)

                        HStack(spacing: 6) {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.system(size: 12))
                            Text(event.location)
                                .font(.custom("PlusJakartaSans-Regular", size: 14))
                        }
                        .foregroundStyle(.Courtside.textSecondary)
                    }

                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 24)
                .contentShape(Rectangle())

                Divider()
                    .padding(.horizontal, 24)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
