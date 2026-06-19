import Foundation

public struct BookingItem: Identifiable {
    public let id = UUID()
    let date: String
    let month: String
    let dayOfWeek: String
    let time: String
    let courtName: String
    let matchType: String
    let isUpcoming: Bool
}

let mockBookings: [BookingItem] = [
    BookingItem(date: "24", month: "OCT", dayOfWeek: "THU", time: "18:00 - 19:30", courtName: "Padel Court 3", matchType: "Doubles Match", isUpcoming: true),
    BookingItem(date: "28", month: "OCT", dayOfWeek: "MON", time: "09:00 - 10:30", courtName: "Padel Court 1", matchType: "Singles Match", isUpcoming: true),
    BookingItem(date: "12", month: "OCT", dayOfWeek: "SAT", time: "16:00 - 17:30", courtName: "Padel Court 2", matchType: "Open Match", isUpcoming: false),
    BookingItem(date: "05", month: "OCT", dayOfWeek: "SAT", time: "10:00 - 11:30", courtName: "Padel Court 4", matchType: "Doubles Match", isUpcoming: false)
]
