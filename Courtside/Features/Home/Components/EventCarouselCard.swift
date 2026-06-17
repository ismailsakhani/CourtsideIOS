import SwiftUI

public struct EventCarouselCard: View {
    let title: String
    let date: String
    let location: String
    
    public init(title: String, date: String, location: String) {
        self.title = title
        self.date = date
        self.location = location
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text(date)
                    .font(.custom("PlusJakartaSans-Regular", size: 12))
                    .foregroundColor(.Courtside.primary)
                    .kerning(1.5)
                
                Text(title)
                    .font(.custom("PlusJakartaSans-Regular", size: 24))
                    .foregroundColor(.Courtside.textPrimary)
                    .lineLimit(2)
            }
            
            Spacer()
            
            HStack {
                Text(location)
                    .font(.custom("PlusJakartaSans-Regular", size: 14))
                    .foregroundColor(.Courtside.textSecondary)
                
                Spacer()
                
                Image(systemName: "arrow.right")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.Courtside.textPrimary)
            }
        }
        .padding(24)
        .frame(width: 260, height: 260)
        .background(Color.Courtside.secondaryBackground)
    }
}
