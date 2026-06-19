import Foundation

struct EventItem: Identifiable {
    let id = UUID()
    let day: String
    let month: String
    let title: String
    let time: String
    let location: String
    let isFeatured: Bool
    let fullDate: String
    let description: String
    let host: String
    let skillLevel: String
    let capacity: String
    let price: String
}

struct EventSection: Identifiable {
    let id = UUID()
    let title: String
    let events: [EventItem]
}
