import SwiftUI

public struct BookingConfirmationView: View {
    let confirmationID: String
    let onDone: () -> Void

    public var body: some View {
        ZStack {
            Color.Courtside.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    VStack(spacing: 32) {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 64, weight: .light))
                            .foregroundStyle(.Courtside.primary)
                            .padding(.top, 80)

                        VStack(spacing: 12) {
                            Text("Booking Confirmed")
                                .font(.Courtside.heroDisplay)
                                .foregroundStyle(.Courtside.textPrimary)
                                .multilineTextAlignment(.center)

                            Text(confirmationID)
                                .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                                .foregroundStyle(.Courtside.primary)
                                .kerning(1)
                        }
                    }
                    .frame(maxWidth: .infinity)

                    Divider()
                        .padding(.horizontal, 32)
                        .padding(.vertical, 40)

                    VStack(alignment: .leading, spacing: 20) {
                        Text("WHAT'S NEXT")
                            .font(.custom("PlusJakartaSans-Regular", size: 12))
                            .foregroundStyle(.Courtside.textSecondary)
                            .kerning(1.5)

                        VStack(spacing: 16) {
                            confirmationRow(icon: "envelope", text: "Confirmation sent to your registered email")
                            confirmationRow(icon: "bell", text: "Reminder 1 hour before your session")
                            confirmationRow(icon: "mappin.and.ellipse", text: "Arrive 10 minutes early to warm up")
                        }
                    }
                    .padding(.horizontal, 32)

                    Divider()
                        .padding(.horizontal, 32)
                        .padding(.vertical, 40)

                    VStack(spacing: 16) {
                        Button {
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "calendar.badge.plus")
                                Text("Add to Calendar")
                            }
                            .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                            .foregroundStyle(.Courtside.primary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(Color.Courtside.primary.opacity(0.08))
                            .clipShape(.capsule)
                        }

                        PrimaryButton(title: "Back to Home") {
                            onDone()
                        }
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 60)
                }
            }
            .scrollIndicators(.hidden)
        }
    }

    private func confirmationRow(icon: String, text: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundStyle(.Courtside.primary)
                .frame(width: 24)
            Text(text)
                .font(.custom("PlusJakartaSans-Regular", size: 15))
                .foregroundStyle(.Courtside.textSecondary)
        }
    }
}
