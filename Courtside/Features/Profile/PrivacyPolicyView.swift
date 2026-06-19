import SwiftUI

public struct PrivacyPolicyView: View {
    @Environment(\.dismiss) private var dismiss
    
    public init() {}
    
    public var body: some View {
        ZStack {
            Color.Courtside.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Custom Header
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20))
                            .foregroundStyle(.Courtside.textPrimary)
                    }
                    
                    Spacer()
                    
                    Text("LEGAL & PRIVACY")
                        .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                        .foregroundStyle(.Courtside.textPrimary)
                        .kerning(1.5)
                    
                    Spacer()
                    
                    // Invisible placeholder to center the title
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20))
                        .opacity(0)
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 16)
                
                Divider()
                    .background(Color.Courtside.textSecondary.opacity(0.1))
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Terms & Conditions")
                                .font(.custom("PlusJakartaSans-SemiBold", size: 20))
                                .foregroundStyle(.Courtside.textPrimary)
                            
                            Text("Welcome to Courtside. By accessing or using our app and facilities, you agree to comply with and be bound by the following terms. Please read them carefully.")
                                .font(.custom("PlusJakartaSans-Regular", size: 14))
                                .foregroundStyle(.Courtside.textSecondary)
                                .lineSpacing(6)
                            
                            Text("Membership rules require all users to maintain a respectful environment. Court bookings are subject to availability and must be cancelled at least 24 hours in advance to avoid a penalty fee. Lounge access is exclusive to active members and their registered guests.")
                                .font(.custom("PlusJakartaSans-Regular", size: 14))
                                .foregroundStyle(.Courtside.textSecondary)
                                .lineSpacing(6)
                        }
                        
                        Divider()
                            .background(Color.Courtside.textSecondary.opacity(0.1))
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Privacy Policy")
                                .font(.custom("PlusJakartaSans-SemiBold", size: 20))
                                .foregroundStyle(.Courtside.textPrimary)
                            
                            Text("Your privacy is of utmost importance to us. This policy outlines how we collect, use, and protect your personal information when you use the Courtside platform.")
                                .font(.custom("PlusJakartaSans-Regular", size: 14))
                                .foregroundStyle(.Courtside.textSecondary)
                                .lineSpacing(6)
                            
                            Text("We collect information you provide directly to us, such as when you create an account, book a court, or communicate with us. We use this information to operate, maintain, and improve our services, as well as to process your transactions and send related information.")
                                .font(.custom("PlusJakartaSans-Regular", size: 14))
                                .foregroundStyle(.Courtside.textSecondary)
                                .lineSpacing(6)
                            
                            Text("We do not share your personal information with third parties except as necessary to provide our services or as required by law. All payment transactions are encrypted and processed through secure gateways.")
                                .font(.custom("PlusJakartaSans-Regular", size: 14))
                                .foregroundStyle(.Courtside.textSecondary)
                                .lineSpacing(6)
                        }
                        
                        Divider()
                            .background(Color.Courtside.textSecondary.opacity(0.1))
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Club Rules")
                                .font(.custom("PlusJakartaSans-SemiBold", size: 20))
                                .foregroundStyle(.Courtside.textPrimary)
                            
                            Text("• Proper athletic attire and non-marking shoes are required on all courts.\n• Food and glass containers are strictly prohibited inside the playing areas.\n• Members are responsible for the conduct of their guests at all times.")
                                .font(.custom("PlusJakartaSans-Regular", size: 14))
                                .foregroundStyle(.Courtside.textSecondary)
                                .lineSpacing(6)
                        }
                    }
                    .padding(24)
                    .padding(.bottom, 64)
                }
                .scrollIndicators(.hidden)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}
