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
    
    public static let isprava = Court(id: "isprava", name: "Isprava Court")
    public static let court2 = Court(id: "c2", name: "Court 2")
    public static let court3 = Court(id: "c3", name: "Court 3")
    public static let pickleball1 = Court(id: "pb1", name: "Court 1")
    public static let studio = Court(id: "studio", name: "Studio")
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
