import SwiftUI

public struct EmptyStateView: View {
    let icon: String
    let title: String
    let subtitle: String
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil

    public var body: some View {
        VStack(spacing: Spacing.lg) {
            Image(systemName: icon)
                .font(.system(size: 48, weight: .ultraLight))
                .foregroundStyle(Color.Courtside.textSecondary.opacity(0.4))

            VStack(spacing: Spacing.xs) {
                Text(title)
                    .font(.Courtside.headingSemiBold)
                    .foregroundStyle(Color.Courtside.textPrimary)

                Text(subtitle)
                    .font(.Courtside.body)
                    .foregroundStyle(Color.Courtside.textSecondary)
                    .multilineTextAlignment(.center)
            }

            if let actionTitle, let action {
                Button(actionTitle, action: action)
                    .font(.Courtside.labelSemiBold)
                    .foregroundStyle(Color.Courtside.primary)
                    .padding(.top, Spacing.xs)
            }
        }
        .padding(Spacing.xl)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
