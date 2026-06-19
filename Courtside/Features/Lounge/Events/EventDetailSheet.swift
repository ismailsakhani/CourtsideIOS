import SwiftUI

public struct EventDetailSheet: View {
    @Environment(\.dismiss) private var dismiss
    let event: EventItem
    @State private var rsvpConfirmed = false

    public var body: some View {
        ZStack {
            Color.Courtside.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.Courtside.textSecondary.opacity(0.04))
                        .frame(height: 400)
                        .overlay(
                            VStack(spacing: 12) {
                                Image(systemName: "photo")
                                    .font(.system(size: 32))
                                    .foregroundStyle(.Courtside.textSecondary.opacity(0.3))
                                Text("Event Flyer Placeholder")
                                    .font(.custom("PlusJakartaSans-Regular", size: 12))
                                    .foregroundStyle(.Courtside.textSecondary.opacity(0.5))
                            }
                        )
                        .overlay(
                            LinearGradient(
                                colors: [Color.Courtside.background.opacity(0), Color.Courtside.background],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )

                    VStack(alignment: .leading, spacing: 32) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(event.title)
                                .font(.Courtside.heroDisplay)
                                .foregroundStyle(.Courtside.textPrimary)

                            Text(event.fullDate)
                                .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                                .foregroundStyle(.Courtside.primary)
                                .kerning(1)
                        }

                        Text(event.description)
                            .font(.custom("PlusJakartaSans-Regular", size: 16))
                            .foregroundStyle(.Courtside.textSecondary)
                            .lineSpacing(8)

                        VStack(spacing: 16) {
                            HStack(spacing: 16) {
                                LogisticBadge(icon: "mappin.and.ellipse", title: "LOCATION", value: event.location)
                                LogisticBadge(icon: "person.2", title: "HOST", value: event.host)
                            }
                            HStack(spacing: 16) {
                                LogisticBadge(icon: "chart.bar", title: "LEVEL", value: event.skillLevel)
                                LogisticBadge(icon: "ticket", title: "CAPACITY", value: event.capacity)
                            }
                        }
                        .padding(.top, 16)
                    }
                    .padding(32)
                    .padding(.bottom, 120)
                }
            }
            .scrollIndicators(.hidden)

            VStack {
                HStack {
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(.Courtside.textPrimary)
                            .padding(16)
                            .background(Color.Courtside.background)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
                    }
                }
                .padding(24)
                Spacer()
            }

            VStack {
                Spacer()
                VStack(spacing: 0) {
                    LinearGradient(
                        colors: [Color.Courtside.background.opacity(0), Color.Courtside.background],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 40)

                    VStack {
                        Button {
                            withAnimation { rsvpConfirmed = true }
                        } label: {
                            Text(rsvpConfirmed ? "RSVP Confirmed ✓" : "RSVP — \(event.price)")
                                .font(.custom("PlusJakartaSans-Bold", size: 14))
                                .foregroundStyle(rsvpConfirmed ? Color.white : Color.Courtside.background)
                                .kerning(1.5)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .background(rsvpConfirmed ? Color.green : Color.Courtside.primary)
                                .clipShape(Capsule())
                                .shadow(color: Color.black.opacity(0.2), radius: 24, y: 12)
                                .animation(.easeInOut(duration: 0.3), value: rsvpConfirmed)
                        }
                        .disabled(rsvpConfirmed)
                        .sensoryFeedback(.success, trigger: rsvpConfirmed)
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 40)
                    .background(Color.Courtside.background)
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

private struct LogisticBadge: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundStyle(.Courtside.primary)
                .frame(width: 24)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.custom("PlusJakartaSans-Bold", size: 10))
                    .foregroundStyle(.Courtside.textSecondary)
                    .kerning(1)

                Text(value)
                    .font(.custom("PlusJakartaSans-SemiBold", size: 13))
                    .foregroundStyle(.Courtside.textPrimary)
            }
            Spacer(minLength: 0)
        }
        .padding(16)
        .background(Color.Courtside.textSecondary.opacity(0.04))
        .clipShape(.rect(cornerRadius: 16))
    }
}
