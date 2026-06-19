import Observation
import SwiftUI

@Observable
@MainActor
public final class BookingCart {
    public var items: [CartItem] = []

    public init() {}

    public func add(_ item: CartItem) {
        guard !items.contains(where: { $0.id == item.id }) else { return }
        items.append(item)
        sortItems()
    }

    public func remove(id: String) {
        items.removeAll { $0.id == id }
    }

    public func toggle(_ item: CartItem) {
        if isSelected(id: item.id) {
            remove(id: item.id)
        } else {
            add(item)
        }
    }

    public func isSelected(id: String) -> Bool {
        items.contains { $0.id == id }
    }

    public func clear() {
        items.removeAll()
    }

    private func sortItems() {
        items.sort { a, b in
            guard let slotA = a.courtSlot, let slotB = b.courtSlot else { return false }
            if slotA.date == slotB.date {
                return slotA.timeString < slotB.timeString
            }
            return slotA.date < slotB.date
        }
    }
}
