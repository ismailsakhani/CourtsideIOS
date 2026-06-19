import SwiftUI

public extension Color {
    struct Courtside {
        /// Primary Brand Color (#6C8663)
        public static let primary = Color(hex: "6C8663")
        
        /// Background (#FAF9F6)
        public static let background = Color(hex: "FAF9F6")
        
        /// Secondary Background (#F3F2EE)
        public static let secondaryBackground = Color(hex: "F3F2EE")
        
        /// Text Primary (#111111)
        public static let textPrimary = Color(hex: "111111")
        
        /// Text Secondary (#666666)
        public static let textSecondary = Color(hex: "666666")
        
        /// Dividers (#E5E5E5)
        public static let divider = Color(hex: "E5E5E5")
    }
}

extension ShapeStyle where Self == Color {
    static var Courtside: Color.Courtside.Type { Color.Courtside.self }
}

// Helper for Hex Colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
