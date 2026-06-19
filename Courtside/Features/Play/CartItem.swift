import Foundation

public enum CartItem: Identifiable, Equatable {
    case courtSlot(SelectedSlot)
    case foodItem(MenuItem, quantity: Int)

    public var id: String {
        switch self {
        case .courtSlot(let slot):
            return slot.id
        case .foodItem(let item, let qty):
            return "\(item.id.uuidString)-qty\(qty)"
        }
    }

    public var displayTitle: String {
        switch self {
        case .courtSlot(let slot):
            return slot.court.name
        case .foodItem(let item, _):
            return item.title
        }
    }

    public var displaySubtitle: String {
        switch self {
        case .courtSlot(let slot):
            return slot.category.rawValue
        case .foodItem(_, let qty):
            return qty > 1 ? "Qty \(qty)" : "Lounge Order"
        }
    }

    public var displayPrice: String {
        switch self {
        case .courtSlot:
            return "₹2,050"
        case .foodItem(let item, let qty):
            let raw = item.price
                .replacingOccurrences(of: "₹", with: "")
                .replacingOccurrences(of: ",", with: "")
            let base = Double(raw) ?? 0
            let total = Int(base * Double(qty))
            return "₹\(total)"
        }
    }

    public var numericPrice: Double {
        switch self {
        case .courtSlot:
            return 1737.29
        case .foodItem(let item, let qty):
            let raw = item.price
                .replacingOccurrences(of: "₹", with: "")
                .replacingOccurrences(of: ",", with: "")
            return (Double(raw) ?? 0) * Double(qty)
        }
    }

    // Convenience for court slot accessors used in CheckoutItemCard
    public var courtSlot: SelectedSlot? {
        if case .courtSlot(let slot) = self { return slot }
        return nil
    }

    public var menuItem: MenuItem? {
        if case .foodItem(let item, _) = self { return item }
        return nil
    }
}
