import SwiftUI

public struct TimeSlotListView: View {
    @Binding var timeSlots: [TimeSlot]
    let selectedDate: Date
    let selectedCategory: GameCategory
    let onBookedTap: () -> Void
    @EnvironmentObject var cart: BookingCart
    
    public init(timeSlots: Binding<[TimeSlot]>, selectedDate: Date, selectedCategory: GameCategory, onBookedTap: @escaping () -> Void) {
        self._timeSlots = timeSlots
        self.selectedDate = selectedDate
        self.selectedCategory = selectedCategory
        self.onBookedTap = onBookedTap
    }
    
    public var body: some View {
        LazyVStack(alignment: .leading, spacing: 48) {
            ForEach($timeSlots, id: \.id) { $slot in
                VStack(alignment: .leading, spacing: 16) {
                    Text(slot.timeString)
                        .font(.custom("PlusJakartaSans-Regular", size: 24))
                        .foregroundColor(.Courtside.textPrimary)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(slot.courts.indices, id: \.self) { index in
                                let status = slot.courts[index]
                                let selectedSlot = SelectedSlot(date: selectedDate, timeString: slot.timeString, court: status.court, category: selectedCategory)
                                let isSelected = cart.isSelected(id: selectedSlot.id)
                                
                                SlotPillView(
                                    status: status,
                                    isPeak: slot.isPeak,
                                    isSelected: isSelected
                                ) {
                                    if status.isBooked {
                                        onBookedTap()
                                    } else {
                                        withAnimation {
                                            cart.toggle(selectedSlot)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                        // Negative padding to allow scroll bleed
                        .padding(.horizontal, -24)
                    }
                }
            }
        }
        .padding(.horizontal, 24)
    }
}
