import SwiftUI

public struct TimeSlotListView: View {
    @Binding var timeSlots: [TimeSlot]
    let selectedDate: Date
    let selectedCategory: GameCategory
    let onBookedTap: () -> Void
    @Environment(BookingCart.self) private var cart

    public init(
        timeSlots: Binding<[TimeSlot]>,
        selectedDate: Date,
        selectedCategory: GameCategory,
        onBookedTap: @escaping () -> Void
    ) {
        self._timeSlots = timeSlots
        self.selectedDate = selectedDate
        self.selectedCategory = selectedCategory
        self.onBookedTap = onBookedTap
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach($timeSlots, id: \.id) { $slot in
                VStack(alignment: .leading, spacing: 12) {
                    Text(slot.timeString)
                        .font(.custom("PlusJakartaSans-Regular", size: 18))
                        .foregroundStyle(Color.Courtside.textPrimary)

                    ScrollView(.horizontal) {
                        HStack(spacing: 12) {
                            ForEach(slot.courts.indices, id: \.self) { index in
                                let status = slot.courts[index]
                                let selectedSlot = SelectedSlot(
                                    date: selectedDate,
                                    timeString: slot.timeString,
                                    court: status.court,
                                    category: selectedCategory
                                )
                                let cartItem = CartItem.courtSlot(selectedSlot)
                                let isSelected = cart.isSelected(id: cartItem.id)

                                SlotPillView(
                                    status: status,
                                    isPeak: slot.isPeak,
                                    isSelected: isSelected
                                ) {
                                    if status.isBooked {
                                        onBookedTap()
                                    } else {
                                        withAnimation {
                                            cart.toggle(cartItem)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                    .scrollIndicators(.hidden)
                    .padding(.horizontal, -24)
                }
                .id(slot.id)
            }
        }
        .padding(.horizontal, 24)
    }
}
