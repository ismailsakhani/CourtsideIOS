import SwiftUI

public struct FloatingCartPillView: View {
    @EnvironmentObject var cart: BookingCart
    let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                // Number of slots
                Text("\(cart.items.count) \(cart.items.count == 1 ? "Slot" : "Slots") Selected")
                    .font(.custom("PlusJakartaSans-Regular", size: 14))
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack(spacing: 8) {
                    Text("Review")
                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                        .kerning(1.5)
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                }
                .foregroundColor(.Courtside.primary)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .background(
                Capsule()
                    .fill(Color.black.opacity(0.85))
                    .shadow(color: Color.black.opacity(0.15), radius: 24, x: 0, y: 12)
            )
            .overlay(
                Capsule()
                    .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
            )
        }
        .padding(.horizontal, 24)
        // Transition will be handled by the parent view
    }
}
