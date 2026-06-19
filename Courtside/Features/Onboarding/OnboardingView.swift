import SwiftUI

public struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var currentPage = 1 // 1-indexed for editorial "01 / 03"
    
    let totalPages = 3
    
    public init() {}
    
    public var body: some View {
        ZStack {
            // Pristine, quiet background
            Color.Courtside.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Navigation Bar
                HStack {
                    Spacer()
                    
                    // Skip Button
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            hasSeenOnboarding = true
                        }
                    }) {
                        Text("Skip")
                            .font(.custom("PlusJakartaSans-Regular", size: 14))
                            .foregroundStyle(.Courtside.textSecondary)
                            .tracking(2) // generous tracking for luxury feel
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .zIndex(1)
                
                // Tab View
                TabView(selection: $currentPage) {
                    
                    // Page 1: Play
                    EditorialPageView(
                        iconName: "figure.tennis",
                        title: "Elevate your game.",
                        subtitle: "World-class Padel & Pickleball\ncourts designed for champions."
                    )
                    .tag(1)
                    
                    // Page 2: Lounge
                    EditorialPageView(
                        iconName: "cup.and.saucer.fill",
                        title: "Fuel the pursuit.",
                        subtitle: "Curated nutrition and specialty\ncoffee to accelerate recovery."
                    )
                    .tag(2)
                    
                    // Page 3: Club
                    EditorialPageView(
                        iconName: "sparkles",
                        title: "The Club.",
                        subtitle: "Exclusive events, tournaments,\nand a community of peers.",
                        isLastPage: true,
                        onEnterClub: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                hasSeenOnboarding = true
                            }
                        }
                    )
                    .tag(3)
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // Bottom Navigation & Pagination
                VStack(spacing: 24) {
                    if currentPage == totalPages {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                hasSeenOnboarding = true
                            }
                        }) {
                            Text("Enter Club")
                                .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 18)
                                .background(Color.Courtside.primary)
                                .clipShape(.rect(cornerRadius: 100))
                        }
                        .padding(.horizontal, 32)
                    } else {
                        // Placeholder height to keep pagination perfectly stable
                        Color.clear.frame(height: 54)
                            .padding(.horizontal, 32)
                    }
                    
                    // Editorial Pagination "01 / 03"
                    Text("0\(currentPage) / 0\(totalPages)")
                        .font(.custom("PlusJakartaSans-Regular", size: 12))
                        .tracking(4)
                        .foregroundStyle(.Courtside.textSecondary.opacity(0.6))
                        .padding(.bottom, 32)
                }
            }
        }
    }
}

struct EditorialPageView: View {
    let iconName: String
    let title: String
    let subtitle: String
    var isLastPage: Bool = false
    var onEnterClub: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 48) {
            Spacer()
            
            // Icon in a delicate fine frame
            ZStack {
                Circle()
                    .stroke(Color.Courtside.primary.opacity(0.15), lineWidth: 1)
                    .frame(width: 180, height: 180)
                
                Image(systemName: iconName)
                    .font(.system(size: 64, weight: .ultraLight))
                    .foregroundStyle(.Courtside.primary)
            }
            
            // Editorial Divider
            Rectangle()
                .fill(Color.Courtside.primary.opacity(0.15))
                .frame(width: 40, height: 1)
            
            // Copy
            VStack(spacing: 20) {
                Text(title)
                    .font(.Courtside.heroDisplay)
                    .foregroundStyle(.Courtside.primary)
                
                Text(subtitle)
                    .font(.custom("PlusJakartaSans-Regular", size: 16))
                    .foregroundStyle(.Courtside.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(8)
            }
            .padding(.horizontal, 32)
            
            Spacer()
        }
    }
}
