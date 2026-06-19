import SwiftUI

public struct FullMenuView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(BookingCart.self) private var cart
    @State private var selectedDish: MenuItem?

    public var body: some View {
        ZStack {
            Color.Courtside.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    HStack {
                        Text("MENU")
                            .font(.Courtside.heroDisplay)
                            .foregroundStyle(.Courtside.primary)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 40)
                    .padding(.bottom, 64)

                    VStack(spacing: 64) {
                        ForEach(fullMenuData) { section in
                            VStack(alignment: .leading, spacing: 32) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(section.title)
                                        .font(.custom("PlusJakartaSans-SemiBold", size: 18))
                                        .foregroundStyle(.Courtside.textPrimary)
                                        .kerning(2)

                                    if let subtitle = section.subtitle {
                                        Text(subtitle)
                                            .font(.custom("PlusJakartaSans-Italic", size: 13))
                                            .foregroundStyle(.Courtside.textSecondary)
                                    }
                                }
                                .padding(.horizontal, section.isSpecial ? 24 : 0)

                                VStack(spacing: 32) {
                                    ForEach(section.items) { item in
                                        MenuRowView(
                                            title: item.title,
                                            description: item.description,
                                            price: item.price,
                                            onRowTapped: { selectedDish = item }
                                        ) {
                                            selectedDish = item
                                        }
                                    }
                                }
                                .padding(.horizontal, section.isSpecial ? 24 : 0)
                            }
                            .padding(.vertical, section.isSpecial ? 32 : 0)
                            .background(
                                Group {
                                    if section.isSpecial {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color.Courtside.textSecondary.opacity(0.04))
                                    }
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 24)

                    VStack(spacing: 32) {
                        Rectangle()
                            .fill(Color.Courtside.textSecondary.opacity(0.2))
                            .frame(width: 32, height: 1)

                        Text("Service charge and applicable taxes are additional. All ingredients are sourced from premium suppliers and prepared fresh daily. Please inform our team of any allergies or dietary requirements.")
                            .font(.custom("PlusJakartaSans-Regular", size: 11))
                            .foregroundStyle(.Courtside.textSecondary.opacity(0.6))
                            .lineSpacing(6)

                        VStack(spacing: 8) {
                            Image(systemName: "diamond.fill")
                                .font(.system(size: 6))
                                .foregroundStyle(.Courtside.textSecondary.opacity(0.3))

                            Text("Designed for performance, recovery,\nand elevated social dining.")
                                .font(.custom("PlusJakartaSans-Italic", size: 11))
                                .foregroundStyle(.Courtside.textSecondary.opacity(0.8))
                                .kerning(0.5)
                        }
                    }
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 48)
                    .padding(.top, 64)
                    .padding(.bottom, 80)
                }
            }
            .scrollIndicators(.hidden)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.Courtside.textPrimary)
                        .padding(8)
                        .contentShape(Rectangle())
                }
            }
        }
        .sheet(item: $selectedDish) { dish in
            DishDetailSheet(dish: dish) {
                withAnimation { cart.add(.foodItem(dish, quantity: 1)) }
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }
}
