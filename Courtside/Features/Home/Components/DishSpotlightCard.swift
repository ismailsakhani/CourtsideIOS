import SwiftUI

struct DishSpotlightCard: View {
    let dish: MenuItem

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .fill(Color.Courtside.textSecondary.opacity(0.04))
                .frame(height: 240)
                .overlay(
                    VStack(spacing: 8) {
                        Image(systemName: "photo")
                            .font(.system(size: 24))
                        Text("Chef's Pick")
                            .font(.custom("PlusJakartaSans-Bold", size: 10))
                            .kerning(1)
                    }
                    .foregroundStyle(.Courtside.textSecondary.opacity(0.3))
                )

            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top) {
                    Text(dish.title)
                        .font(.custom("PlusJakartaSans-Regular", size: 24))
                        .foregroundStyle(.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)

                    Spacer()

                    Text(dish.price)
                        .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                        .foregroundStyle(.Courtside.primary)
                }

                Text(dish.description ?? "")
                    .font(.custom("PlusJakartaSans-Regular", size: 14))
                    .foregroundStyle(.white.opacity(0.6))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .padding(24)
            .background(Color.Courtside.primary)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: Color.black.opacity(0.15), radius: 24, y: 12)
    }
}
