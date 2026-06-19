import Foundation

public enum GameCategory: String, CaseIterable, Equatable {
    case padel = "PADEL"
    case pickleball = "PICKLEBALL"
    case studio = "STUDIO"
    case recovery = "RECOVERY"
}

public struct Court: Equatable {
    public let id: String
    public let name: String
    
    public static let court1       = Court(id: "c1",      name: "Court 1")
    public static let court2       = Court(id: "c2",      name: "Court 2")
    public static let court3       = Court(id: "c3",      name: "Court 3")
    public static let isprava      = Court(id: "isprava", name: "Isprava Court")
    public static let pickleball1  = Court(id: "pb1",     name: "Court 1")
    // Studio classes
    public static let barre57      = Court(id: "barre57",  name: "Barre 57 by Physique 57")
    public static let reformer     = Court(id: "reformer", name: "Reformer Pilates")
    public static let yoga         = Court(id: "yoga",     name: "Hot Yoga Flow")
    // Recovery rooms
    public static let room1        = Court(id: "room1",   name: "Room 1")
    public static let room2        = Court(id: "room2",   name: "Room 2")
}

public struct CourtStatus: Equatable {
    public let court: Court
    public let isBooked: Bool
    public var isSelected: Bool
}

public struct TimeSlot: Equatable {
    public let timeString: String
    public let hour: Int
    public let minute: Int
    public var courts: [CourtStatus]
    public let isPeak: Bool
    public let id = UUID()
}

public struct SelectedSlot: Equatable {
    public let id: String
    public let date: Date
    public let timeString: String
    public let court: Court
    public let category: GameCategory

    public init(date: Date, timeString: String, court: Court, category: GameCategory) {
        self.date = date
        self.timeString = timeString
        self.court = court
        self.category = category
        self.id = "\(court.id)-\(timeString)-\(Int(date.timeIntervalSince1970))"
    }
}
