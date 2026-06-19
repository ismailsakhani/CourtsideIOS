import Foundation

public struct EventRSVPItem: Identifiable {
    public let id = UUID()
    let title: String
    let dateStr: String
    let timeStr: String
    let locationStr: String
    let isUpcoming: Bool
}

let mockRSVPs: [EventRSVPItem] = [
    EventRSVPItem(title: "Summer Solstice Tournament", dateStr: "24 Oct", timeStr: "10:00 AM - 4:00 PM", locationStr: "Main Courts", isUpcoming: true),
    EventRSVPItem(title: "Evening Mixer & DJ", dateStr: "28 Oct", timeStr: "7:00 PM - 11:00 PM", locationStr: "Lounge & Terrace", isUpcoming: true),
    EventRSVPItem(title: "Pro Exhibition Match", dateStr: "12 Oct", timeStr: "6:00 PM - 8:00 PM", locationStr: "Center Court", isUpcoming: false)
]
