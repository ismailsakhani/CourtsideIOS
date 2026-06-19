import SwiftUI

public struct ChangePasswordSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var linkSent = false

    public var body: some View {
        ZStack {
            Color.Courtside.background.ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(.Courtside.textPrimary)
                            .padding(16)
                            .background(Color.Courtside.background)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.08), radius: 10)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)

                VStack(alignment: .leading, spacing: 40) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Change Password")
                            .font(.Courtside.heroDisplay)
                            .foregroundStyle(.Courtside.textPrimary)

                        Text("We'll send a reset link to your registered email address.")
                            .font(.custom("PlusJakartaSans-Regular", size: 16))
                            .foregroundStyle(.Courtside.textSecondary)
                            .lineSpacing(4)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("EMAIL")
                            .font(.custom("PlusJakartaSans-Regular", size: 11))
                            .foregroundStyle(.Courtside.textSecondary)
                            .kerning(1.2)

                        Text("m.chen@example.com")
                            .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                            .foregroundStyle(.Courtside.textPrimary)
                            .padding(20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.Courtside.textSecondary.opacity(0.05))
                            .clipShape(.rect(cornerRadius: 16))
                    }

                    if linkSent {
                        HStack(spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                            Text("Link sent to m.chen@example.com")
                                .font(.custom("PlusJakartaSans-SemiBold", size: 15))
                                .foregroundStyle(.Courtside.textPrimary)
                        }
                        .padding(20)
                        .background(Color.green.opacity(0.08))
                        .clipShape(.rect(cornerRadius: 16))
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }

                    Spacer()

                    PrimaryButton(title: linkSent ? "Link Sent" : "Send Reset Link") {
                        withAnimation { linkSent = true }
                    }
                    .disabled(linkSent)
                    .padding(.bottom, 40)
                }
                .padding(.horizontal, 32)
                .padding(.top, 32)
            }
        }
    }
}
