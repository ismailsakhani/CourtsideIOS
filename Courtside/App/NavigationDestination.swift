import SwiftUI

enum ProfileDestination: Hashable {
    case myBookings
    case orderHistory
    case eventRSVPs
    case notifications
    case privacy
    case manageAccount
}

enum ContentDestination: Hashable {
    case allEvents
    case fullMenu
}
