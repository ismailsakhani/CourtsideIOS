import SwiftUI

public struct RSVPConfirmationSheet: View {
    @Environment(\.dismiss) private var dismiss
    let event: EventItem
    let confirmationNumber: String

    public var body: some View {
        ZStack {
            Color.Courtside.background.ignoresSafeArea()

            VStack(spacing: 32) {
                VStack(spacing: 16) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 56, weight: .light))
                        .foregroundStyle(.Courtside.primary)

                    Text("RSVP Confirmed")
                        .font(.Courtside.heroDisplay)
                        .foregroundStyle(.Courtside.textPrimary)

                    Text(confirmationNumber)
                        .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                        .foregroundStyle(.Courtside.primary)
                        .kerning(1)
                }
                .padding(.top, 48)

                Divider().padding(.horizontal, 32)

                VStack(alignment: .leading, spacing: 16) {
                    rsvpDetailRow(label: "EVENT", value: event.title)
                    rsvpDetailRow(label: "DATE", value: event.fullDate)
                    rsvpDetailRow(label: "TIME", value: event.time)
                    rsvpDetailRow(label: "LOCATION", value: event.location)
                }
                .padding(.horizontal, 32)

                Spacer()

                PrimaryButton(title: "Done") {
                    dismiss()
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 48)
            }
        }
    }

    private func rsvpDetailRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.custom("PlusJakartaSans-Regular", size: 11))
                .foregroundStyle(.Courtside.textSecondary)
                .kerning(1.2)
                .frame(width: 80, alignment: .leading)
            Text(value)
                .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                .foregroundStyle(.Courtside.textPrimary)
        }
    }
}
