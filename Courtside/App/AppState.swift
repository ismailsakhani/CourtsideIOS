import Observation

@Observable
@MainActor
public final class AppState {
    public static let shared = AppState()

    public var memberFirstName: String = "Member"
    public var memberFullName: String = "Ismail Sakhani"
    public var memberTier: String = "Founder Member"
    public var memberSince: String = "2024"
    public var memberID: String = "001 842 931"
    public var walletBalance: Double = 500.00

    private init() {
        // Seed with demo member data for prototype
        memberFirstName = "Ismail"
    }
}
