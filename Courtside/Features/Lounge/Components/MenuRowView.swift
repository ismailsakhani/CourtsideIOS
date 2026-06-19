import SwiftUI

public struct MenuRowView: View {
    let title: String
    let description: String?
    let price: String
    let onRowTapped: () -> Void
    let onAdd: () -> Void

    public var body: some View {
        Button(action: onRowTapped) {
            HStack(alignment: .top, spacing: 16) {
                Rectangle()
                    .fill(Color.Courtside.textSecondary.opacity(0.06))
                    .frame(width: 72, height: 72)
                    .overlay(
                        Image(systemName: "camera.macro")
                            .font(.system(size: 16))
                            .foregroundStyle(.Courtside.textSecondary.opacity(0.3))
                    )
                    .clipShape(.rect(cornerRadius: 8))

                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                        .foregroundStyle(.Courtside.textPrimary)
                        .multilineTextAlignment(.leading)

                    if let desc = description {
                        Text(desc)
                            .font(.custom("PlusJakartaSans-Regular", size: 14))
                            .foregroundStyle(.Courtside.textSecondary)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                    }

                    HStack(alignment: .bottom, spacing: 12) {
                        Text(price)
                            .font(.custom("PlusJakartaSans-SemiBold", size: 15))
                            .foregroundStyle(.Courtside.primary)

                        Text("VIEW DETAILS")
                            .font(.custom("PlusJakartaSans-SemiBold", size: 9))
                            .foregroundStyle(.Courtside.textSecondary.opacity(0.6))
                            .kerning(1)
                            .padding(.bottom, 2)
                    }
                    .padding(.top, 2)
                }

                Spacer()

                Button(action: onAdd) {
                    HStack(spacing: 4) {
                        Image(systemName: "plus")
                            .font(.system(size: 10, weight: .bold))
                        Text("ADD")
                            .font(.custom("PlusJakartaSans-Bold", size: 11))
                            .kerning(1)
                    }
                    .foregroundStyle(.Courtside.primary)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.Courtside.primary.opacity(0.08))
                    .clipShape(Capsule())
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}
