import SwiftUI

public struct MembershipQRSheet: View {
    @Environment(AppState.self) private var appState

    public var body: some View {
        ZStack {
            Color.Courtside.background.ignoresSafeArea()

            VStack(spacing: 32) {
                Text("MEMBER ACCESS")
                    .font(.custom("PlusJakartaSans-Regular", size: 11))
                    .foregroundStyle(.Courtside.textSecondary)
                    .kerning(2)
                    .padding(.top, 48)

                Image(systemName: "qrcode")
                    .font(.system(size: 200, weight: .ultraLight))
                    .foregroundStyle(.Courtside.primary)

                VStack(spacing: 8) {
                    Text(appState.memberFullName)
                        .font(.custom("PlusJakartaSans-SemiBold", size: 22))
                        .foregroundStyle(.Courtside.textPrimary)

                    Text(appState.memberID)
                        .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                        .foregroundStyle(.Courtside.textSecondary)
                        .kerning(1)
                }

                Text("Show at reception")
                    .font(.custom("PlusJakartaSans-Regular", size: 14))
                    .foregroundStyle(.Courtside.textSecondary)

                Spacer()
            }
        }
    }
}
