import SwiftUI

public extension View {
    /// Soft card shadow — white cards on FAF9F6 background
    func cardShadow() -> some View {
        self.shadow(color: .black.opacity(0.06), radius: 24, x: 0, y: 8)
    }

    /// Subtle micro shadow — tight list rows and inline elements
    func subtleShadow() -> some View {
        self.shadow(color: .black.opacity(0.04), radius: 12, x: 0, y: 4)
    }

    /// Lifted action shadow — floating buttons and CTAs
    func actionShadow() -> some View {
        self.shadow(color: Color.Courtside.primary.opacity(0.3), radius: 24, x: 0, y: 12)
    }
}
