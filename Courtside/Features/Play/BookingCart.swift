import Foundation
import SwiftUI
import Combine

public struct SelectedSlot: Identifiable, Equatable {
    public let id: String
    public let date: Date
    public let timeString: String
    public let court: Court
    public let category: GameCategory
    
    public init(date: Date, timeString: String, court: Court, category: GameCategory) {
        self.date = Calendar.current.startOfDay(for: date)
        self.timeString = timeString
        self.court = court
        self.category = category
        self.id = "\(self.date.timeIntervalSince1970)-\(timeString)-\(court.id)"
    }
}

public class BookingCart: ObservableObject {
    @Published public var items: [SelectedSlot] = []
    
    public init() {}
    
    public func add(_ slot: SelectedSlot) {
        if !items.contains(where: { $0.id == slot.id }) {
            items.append(slot)
            sortItems()
        }
    }
    
    public func remove(_ id: String) {
        items.removeAll { $0.id == id }
    }
    
    public func toggle(_ slot: SelectedSlot) {
        if isSelected(id: slot.id) {
            remove(slot.id)
        } else {
            add(slot)
        }
    }
    
    public func isSelected(id: String) -> Bool {
        items.contains(where: { $0.id == id })
    }
    
    private func sortItems() {
        items.sort {
            if $0.date == $1.date {
                return $0.timeString < $1.timeString
            }
            return $0.date < $1.date
        }
    }
}
