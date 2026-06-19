import SwiftUI

@main
struct CourtsideApp: App {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    private let appState = AppState.shared

    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                MainTabView()
                    .environment(appState)
            } else {
                OnboardingView()
                    .environment(appState)
            }
        }
    }
}
 

