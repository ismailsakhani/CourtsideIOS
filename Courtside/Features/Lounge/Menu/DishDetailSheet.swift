import SwiftUI

public struct DishDetailSheet: View {
    let dish: MenuItem
    let onAdd: () -> Void
    @Environment(\.dismiss) private var dismiss

    public var body: some View {
        ZStack(alignment: .bottom) {
            Color.Courtside.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.Courtside.textSecondary.opacity(0.08))
                        .frame(height: 320)
                        .overlay(
                            VStack(spacing: 12) {
                                Image(systemName: "camera.macro")
                                    .font(.system(size: 32))
                                    .foregroundStyle(.Courtside.textSecondary.opacity(0.4))
                                Text("Image Placeholder")
                                    .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                                    .foregroundStyle(.Courtside.textSecondary.opacity(0.6))
                                    .kerning(1)
                            }
                        )

                    VStack(alignment: .leading, spacing: 40) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(dish.title)
                                .font(.Courtside.heroDisplay)
                                .foregroundStyle(.Courtside.textPrimary)

                            Text(dish.price)
                                .font(.custom("PlusJakartaSans-SemiBold", size: 18))
                                .foregroundStyle(.Courtside.primary)

                            if let desc = dish.description {
                                Text(desc)
                                    .font(.custom("PlusJakartaSans-Regular", size: 15))
                                    .foregroundStyle(.Courtside.textSecondary)
                                    .lineSpacing(6)
                                    .padding(.top, 4)
                            }
                        }

                        VStack(alignment: .leading, spacing: 20) {
                            Text("NUTRITIONAL PROFILE")
                                .font(.custom("PlusJakartaSans-SemiBold", size: 11))
                                .foregroundStyle(.Courtside.textSecondary)
                                .kerning(2)

                            HStack(spacing: 12) {
                                MacroBadge(label: "CALORIES", value: dish.macros.calories)
                                MacroBadge(label: "PROTEIN", value: dish.macros.protein)
                                MacroBadge(label: "CARBS", value: dish.macros.carbs)
                                MacroBadge(label: "FATS", value: dish.macros.fats)
                            }
                        }

                        VStack(alignment: .leading, spacing: 20) {
                            Text("INGREDIENTS")
                                .font(.custom("PlusJakartaSans-SemiBold", size: 11))
                                .foregroundStyle(.Courtside.textSecondary)
                                .kerning(2)

                            VStack(alignment: .leading, spacing: 16) {
                                ForEach(dish.ingredients, id: \.self) { ingredient in
                                    HStack(alignment: .top, spacing: 16) {
                                        Circle()
                                            .fill(Color.Courtside.primary.opacity(0.6))
                                            .frame(width: 4, height: 4)
                                            .padding(.top, 8)
                                        Text(ingredient)
                                            .font(.custom("PlusJakartaSans-Regular", size: 15))
                                            .foregroundStyle(.Courtside.textPrimary)
                                    }
                                }
                            }
                        }
                    }
                    .padding(32)
                    .padding(.bottom, 140)
                }
            }
            .scrollIndicators(.hidden)

            VStack {
                Button(action: {
                    onAdd()
                    dismiss()
                }) {
                    Text("ADD TO ORDER — \(dish.price)")
                        .font(.custom("PlusJakartaSans-Bold", size: 14))
                        .foregroundStyle(.white)
                        .kerning(1.5)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(Color.Courtside.primary)
                        .clipShape(Capsule())
                        .shadow(color: Color.black.opacity(0.2), radius: 24, y: 12)
                }
            }
            .padding(32)
            .background(
                LinearGradient(
                    colors: [Color.Courtside.background, Color.Courtside.background.opacity(0)],
                    startPoint: .bottom,
                    endPoint: .top
                )
                .frame(height: 160)
                .offset(y: 20)
            )
        }
    }
}

public struct MacroBadge: View {
    let label: String
    let value: String

    public var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                .foregroundStyle(.Courtside.textPrimary)
            Text(label)
                .font(.custom("PlusJakartaSans-Regular", size: 9))
                .foregroundStyle(.Courtside.textSecondary)
                .kerning(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color.Courtside.textSecondary.opacity(0.04))
        .clipShape(.rect(cornerRadius: 16))
    }
}
