import SwiftUI

public struct SlotPillView: View {
    let status: CourtStatus
    let isPeak: Bool
    let isSelected: Bool
    let action: () -> Void
    
    public init(status: CourtStatus, isPeak: Bool, isSelected: Bool, action: @escaping () -> Void) {
        self.status = status
        self.isPeak = isPeak
        self.isSelected = isSelected
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            action()
        }) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text(status.court.name)
                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                    
                    if isPeak && !status.isBooked {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 10))
                    }
                }
                
                Text("₹2050")
                    .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                    .foregroundColor(textColor.opacity(0.8))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .foregroundColor(textColor)
            .background(backgroundColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 0.5)
            )
        }
    }
    
    private var textColor: Color {
        if isSelected { return .white }
        if status.isBooked { return .Courtside.textSecondary }
        if isPeak { return .Courtside.primary }
        return .Courtside.textPrimary
    }
    
    private var backgroundColor: Color {
        if isSelected { return .Courtside.primary }
        if status.isBooked { return Color.Courtside.textPrimary.opacity(0.03) }
        if isPeak && !status.isBooked { return Color.Courtside.primary.opacity(0.05) }
        return .white
    }
    
    private var borderColor: Color {
        if isSelected { return .clear }
        if status.isBooked { return Color.Courtside.textPrimary.opacity(0.1) }
        if isPeak { return Color.Courtside.primary.opacity(0.3) }
        return Color.Courtside.textPrimary.opacity(0.1)
    }
}
