import SwiftUI

public struct CheckoutView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(BookingCart.self) private var cart

    @State private var useWalletBalance = false
    @State private var bookingConfirmed = false
    @State private var confirmationID = ""

    private var subtotal: Double {
        cart.items.reduce(0) { $0 + $1.numericPrice }
    }
    private var gstAmount: Double { subtotal * 0.18 }
    private var grandTotal: Double { subtotal + gstAmount }

    public init() {}

    public var body: some View {
        NavigationStack {
            ZStack {
                Color.Courtside.background.ignoresSafeArea()

                if cart.items.isEmpty {
                    EmptyStateView(
                        icon: "tennis.racket",
                        title: "No slots selected",
                        subtitle: "Go to Play to select court slots."
                    )
                } else {
                    ScrollView {
                        VStack(spacing: 32) {
                            VStack(spacing: 24) {
                                ForEach(cart.items) { item in
                                    CheckoutItemCard(item: item)
                                }
                            }

                            CheckoutCouponRow()

                            CheckoutWalletRow(useWalletBalance: $useWalletBalance)

                            CheckoutPaymentSummary(
                                subtotal: subtotal,
                                gstAmount: gstAmount,
                                grandTotal: grandTotal
                            )

                            PrimaryButton(title: "Confirm Booking") {
                                confirmationID = generateConfirmationID()
                                cart.clear()
                                bookingConfirmed = true
                            }
                            .padding(.horizontal, 24)
                            .padding(.top, 16)

                            Text("By confirming your booking, you agree to our Terms & Conditions and Cancellation Policy.")
                                .font(.custom("PlusJakartaSans-Regular", size: 12))
                                .foregroundStyle(Color.Courtside.textSecondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                                .padding(.bottom, 40)
                        }
                        .padding(.top, 24)
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color.Courtside.textPrimary)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $bookingConfirmed) {
            BookingConfirmationView(confirmationID: confirmationID) {
                bookingConfirmed = false
                dismiss()
            }
        }
        .sensoryFeedback(.success, trigger: bookingConfirmed)
    }

    private func generateConfirmationID() -> String {
        let number = Int.random(in: 10000...99999)
        return "CST-\(number)"
    }
}

// MARK: - CheckoutItemCard

public struct CheckoutItemCard: View {
    @Environment(BookingCart.self) private var cart
    let item: CartItem

    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.displaySubtitle)
                        .font(.custom("PlusJakartaSans-Regular", size: 10))
                        .kerning(1.5)
                        .foregroundStyle(Color.Courtside.primary)

                    Text(item.displayTitle)
                        .font(.custom("PlusJakartaSans-Regular", size: 20))
                        .foregroundStyle(Color.Courtside.textPrimary)
                }

                Spacer()

                Text(item.displayPrice)
                    .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                    .foregroundStyle(Color.Courtside.primary)

                Button {
                    withAnimation {
                        cart.remove(id: item.id)
                    }
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 16, weight: .light))
                        .foregroundStyle(Color.Courtside.textSecondary)
                }
                .padding(.leading, 12)
            }

            if let slot = item.courtSlot {
                Divider()

                HStack {
                    HStack(spacing: 8) {
                        Image(systemName: "calendar")
                            .foregroundStyle(Color.Courtside.textSecondary)
                        Text(slot.date, format: .dateTime.weekday(.abbreviated).day().month(.abbreviated))
                            .font(.custom("PlusJakartaSans-Regular", size: 14))
                            .foregroundStyle(Color.Courtside.textPrimary)
                    }

                    Spacer()

                    HStack(spacing: 8) {
                        Image(systemName: "clock")
                            .foregroundStyle(Color.Courtside.textSecondary)
                        Text(slot.timeString)
                            .font(.custom("PlusJakartaSans-Regular", size: 14))
                            .foregroundStyle(Color.Courtside.textPrimary)
                    }
                }
            }
        }
        .padding(24)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 24))
        .shadow(color: .black.opacity(0.04), radius: 12, x: 0, y: 4)
        .padding(.horizontal, 24)
    }
}

// MARK: - CheckoutCouponRow

public struct CheckoutCouponRow: View {
    @State private var couponCode = ""

    public var body: some View {
        HStack {
            TextField("Apply Coupon / Voucher", text: $couponCode)
                .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                .foregroundStyle(Color.Courtside.textPrimary)
                .textInputAutocapitalization(.characters)

            Spacer()

            Button("Apply") {}
                .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                .foregroundStyle(couponCode.isEmpty ? Color.Courtside.textSecondary : Color.Courtside.primary)
                .disabled(couponCode.isEmpty)
        }
        .padding(20)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 16))
        .padding(.horizontal, 24)
    }
}

// MARK: - CheckoutWalletRow

public struct CheckoutWalletRow: View {
    @Binding var useWalletBalance: Bool
    @State private var showAddMoney = false

    public var body: some View {
        VStack(spacing: 16) {
            HStack {
                HStack(spacing: 12) {
                    Image(systemName: "creditcard.fill")
                        .foregroundStyle(Color.Courtside.primary)
                    Text("Wallet Balance (₹500)")
                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                        .foregroundStyle(Color.Courtside.textPrimary)
                }
                Spacer()
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        useWalletBalance.toggle()
                    }
                } label: {
                    ZStack {
                        Capsule()
                            .fill(useWalletBalance ? Color.Courtside.primary : Color.Courtside.textSecondary.opacity(0.3))
                            .frame(width: 50, height: 30)

                        Circle()
                            .fill(Color.white)
                            .frame(width: 26, height: 26)
                            .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 1)
                            .offset(x: useWalletBalance ? 10 : -10)
                    }
                }
                .accessibilityLabel(useWalletBalance ? "Wallet enabled" : "Wallet disabled")
            }

            HStack {
                Spacer()
                Button("+ Add Money") {
                    showAddMoney = true
                }
                .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                .foregroundStyle(Color.Courtside.primary)
            }
        }
        .padding(20)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 16))
        .padding(.horizontal, 24)
        .sheet(isPresented: $showAddMoney) {
            AddMoneySheet()
        }
    }
}

// MARK: - CheckoutPaymentSummary

public struct CheckoutPaymentSummary: View {
    let subtotal: Double
    let gstAmount: Double
    let grandTotal: Double

    public var body: some View {
        VStack(spacing: 16) {
            Text("Payment Summary")
                .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                .foregroundStyle(Color.Courtside.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 12) {
                summaryRow(label: "Subtotal", value: subtotal)
                summaryRow(label: "GST (18%)", value: gstAmount)

                Divider().padding(.vertical, 8)

                HStack {
                    Text("Grand Total")
                        .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                        .foregroundStyle(Color.Courtside.textPrimary)
                    Spacer()
                    Text(grandTotal, format: .currency(code: "INR").presentation(.isoCode))
                        .font(.custom("PlusJakartaSans-SemiBold", size: 18))
                        .foregroundStyle(Color.Courtside.primary)
                }
            }
        }
        .padding(24)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 24))
        .shadow(color: .black.opacity(0.04), radius: 12, x: 0, y: 4)
        .padding(.horizontal, 24)
    }

    private func summaryRow(label: String, value: Double) -> some View {
        HStack {
            Text(label)
                .font(.custom("PlusJakartaSans-Regular", size: 14))
                .foregroundStyle(Color.Courtside.textSecondary)
            Spacer()
            Text(value, format: .currency(code: "INR").presentation(.isoCode))
                .font(.custom("PlusJakartaSans-Regular", size: 14))
                .foregroundStyle(Color.Courtside.textPrimary)
        }
    }
}
