import SwiftUI

public struct BookingTicketCard: View {
    public init() {}
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text("UPCOMING BOOKING")
                    .font(.custom("PlusJakartaSans-Regular", size: 12))
                    .foregroundColor(.Courtside.background.opacity(0.6))
                    .kerning(1.5)
                
                Spacer()
                
                Image(systemName: "calendar")
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(.Courtside.background)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Padel Court 3")
                    .font(.custom("PlusJakartaSans-Regular", size: 32))
                    .foregroundColor(.Courtside.background)
                
                Text("With Michael & Sarah")
                    .font(.custom("PlusJakartaSans-Regular", size: 16))
                    .foregroundColor(.Courtside.background.opacity(0.8))
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("DATE")
                        .font(.custom("PlusJakartaSans-Regular", size: 10))
                        .foregroundColor(.Courtside.background.opacity(0.6))
                    Text("17 June")
                        .font(.custom("PlusJakartaSans-Regular", size: 16))
                        .foregroundColor(.Courtside.background)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("TIME")
                        .font(.custom("PlusJakartaSans-Regular", size: 10))
                        .foregroundColor(.Courtside.background.opacity(0.6))
                    Text("8:00 PM - 9:30 PM")
                        .font(.custom("PlusJakartaSans-Regular", size: 16))
                        .foregroundColor(.Courtside.background)
                }
            }
            .padding(.top, 8)
        }
        .padding(24)
        .background(Color.Courtside.textPrimary) // Inverted black card
    }
}
