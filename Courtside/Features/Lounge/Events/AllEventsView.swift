import SwiftUI

public struct AllEventsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedEvent: EventItem?

    public var body: some View {
        ZStack {
            Color.Courtside.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    HStack {
                        Text("Experiences")
                            .font(.Courtside.heroDisplay)
                            .foregroundStyle(.Courtside.primary)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 40)
                    .padding(.bottom, 48)

                    VStack(spacing: 64) {
                        ForEach(allEventsData) { section in
                            VStack(alignment: .leading, spacing: 32) {
                                Text(section.title)
                                    .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                                    .foregroundStyle(.Courtside.textSecondary)
                                    .kerning(2)
                                    .padding(.horizontal, 24)

                                VStack(spacing: 16) {
                                    ForEach(section.events) { event in
                                        VStack(spacing: 0) {
                                            Button(action: { selectedEvent = event }) {
                                                if event.isFeatured {
                                                    HeroEventCard(event: event)
                                                        .padding(.horizontal, 24)
                                                        .padding(.bottom, 16)
                                                } else {
                                                    EditorialEventRow(event: event)
                                                        .padding(.horizontal, 24)
                                                }
                                            }
                                            .buttonStyle(PlainButtonStyle())

                                            if !event.isFeatured && event.id != section.events.last?.id {
                                                Rectangle()
                                                    .fill(Color.Courtside.textSecondary.opacity(0.08))
                                                    .frame(height: 1)
                                                    .padding(.leading, 96)
                                                    .padding(.trailing, 24)
                                                    .padding(.vertical, 8)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom, 120)
                }
            }
            .scrollIndicators(.hidden)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.Courtside.textPrimary)
                        .padding(8)
                        .contentShape(Rectangle())
                }
            }
        }
        .sheet(item: $selectedEvent) { event in
            EventDetailSheet(event: event)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        }
    }
}
