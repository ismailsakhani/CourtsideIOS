import SwiftUI

public struct OrderHistoryView: View {
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
                    
                    Text("ORDER HISTORY")
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
                
                // Continuous Scroll Feed
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {

                        if mockOrders.isEmpty {
                            EmptyStateView(
                                icon: "cup.and.saucer",
                                title: "No orders yet",
                                subtitle: "Browse The Optimist menu and place your first order.",
                                actionTitle: "View Menu",
                                action: {}
                            )
                        }

                        if !mockOrders.isEmpty {
                            VStack(alignment: .leading, spacing: 24) {
                                Text("RECENT ORDERS")
                                    .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                                    .foregroundStyle(.Courtside.textSecondary)
                                    .kerning(1.5)
                                    .padding(.horizontal, 24)
                                    .padding(.top, 32)
                                
                                ForEach(mockOrders) { order in
                                    OrderCardView(order: order)
                                        .padding(.horizontal, 24)
                                }
                            }
                            .padding(.bottom, 64)
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct OrderCardView: View {
    let order: OrderHistoryItem
    @State private var reorderTrigger = false
    @State private var showToast = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Top Row: Date & Order ID
            HStack {
                Text(order.dateStr)
                    .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                    .foregroundStyle(.Courtside.textSecondary)

                Spacer()

                Text(order.orderNumber)
                    .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                    .foregroundStyle(.Courtside.primary)
            }

            // Middle Row: Items Summary
            Text(order.itemsStr)
                .font(.custom("PlusJakartaSans-Regular", size: 16))
                .foregroundStyle(.Courtside.textPrimary.opacity(0.9))
                .lineLimit(2)
                .padding(.vertical, 4)

            if showToast {
                Text("Item added to your order")
                    .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                    .foregroundStyle(.green)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }

            Divider()
                .background(Color.Courtside.textSecondary.opacity(0.1))

            // Bottom Row: Total & Action
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total")
                        .font(.custom("PlusJakartaSans-Regular", size: 12))
                        .foregroundStyle(.Courtside.textSecondary)
                    Text(order.totalAmount)
                        .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                        .foregroundStyle(.Courtside.textPrimary)
                }

                Spacer()

                Button(action: {
                    reorderTrigger.toggle()
                    withAnimation { showToast = true }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation { showToast = false }
                    }
                }) {
                    Text("Reorder")
                        .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.Courtside.primary)
                        .clipShape(.rect(cornerRadius: 100))
                }
                .sensoryFeedback(.success, trigger: reorderTrigger)
            }
        }
        .padding(24)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 24))
        .shadow(color: Color.black.opacity(0.04), radius: 16, y: 8)
    }
}
