import SwiftUI

public struct CheckoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var cart: BookingCart
    
    private var sortedItems: [SelectedSlot] {
        cart.items // Items are already sorted by the BookingCart, but we can group them
    }
    
    @State private var useWalletBalance = false
    
    private var basePrice: Double { 1737.29 * Double(cart.items.count) }
    private var gstAmount: Double { 312.71 * Double(cart.items.count) }
    private var grandTotal: Double { 2050.00 * Double(cart.items.count) }
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            ZStack {
                Color.Courtside.background.ignoresSafeArea()
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                
                if cart.items.isEmpty {
                    VStack(spacing: 24) {
                        Image(systemName: "tennis.racket")
                            .font(.system(size: 48, weight: .light))
                            .foregroundColor(.Courtside.textSecondary)
                        
                        Text("No slots selected")
                            .font(.custom("PlusJakartaSans-Regular", size: 16))
                            .foregroundColor(.Courtside.textSecondary)
                    }
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 32) {
                            // 1. Selected Slots
                            VStack(spacing: 24) {
                                ForEach(sortedItems) { item in
                                    CheckoutItemCard(item: item)
                                }
                            }
                            
                            // 2. Coupon & Voucher
                            CheckoutCouponRow()
                            
                            // 3. Wallet Balance
                            CheckoutWalletRow(useWalletBalance: $useWalletBalance)
                            
                            // 4. Payment Summary Math
                            CheckoutPaymentSummary(basePrice: basePrice, gstAmount: gstAmount, grandTotal: grandTotal)
                            
                            // 5. Confirm Button
                            PrimaryButton(title: "Confirm Booking") {
                                cart.items.removeAll()
                                presentationMode.wrappedValue.dismiss()
                            }
                            .padding(.horizontal, 24)
                            .padding(.top, 16)
                            
                            // 6. Terms
                            Text("By confirming your booking, you agree to our Terms & Conditions and Cancellation Policy.")
                                .font(.custom("PlusJakartaSans-Regular", size: 12))
                                .foregroundColor(.Courtside.textSecondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                                .padding(.bottom, 40)
                        }
                        .padding(.top, 24)
                    }
                }
            }
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.Courtside.textPrimary)
                    }
                }
            }
        }
    }
}

public struct CheckoutItemCard: View {
    @EnvironmentObject var cart: BookingCart
    let item: SelectedSlot
    
    private var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, d MMM"
        return formatter.string(from: item.date).uppercased()
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.category.rawValue)
                        .font(.custom("PlusJakartaSans-Regular", size: 10))
                        .kerning(1.5)
                        .foregroundColor(.Courtside.primary)
                    
                    Text(item.court.name)
                        .font(.custom("PlusJakartaSans-Regular", size: 20))
                        .foregroundColor(.Courtside.textPrimary)
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        cart.remove(item.id)
                    }
                }) {
                    Image(systemName: "trash")
                        .font(.system(size: 16, weight: .light))
                        .foregroundColor(.Courtside.textSecondary)
                }
            }
            
            Divider()
            
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "calendar")
                        .foregroundColor(.Courtside.textSecondary)
                    Text(dateString)
                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                        .foregroundColor(.Courtside.textPrimary)
                }
                
                Spacer()
                
                HStack(spacing: 8) {
                    Image(systemName: "clock")
                        .foregroundColor(.Courtside.textSecondary)
                    Text(item.timeString)
                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                        .foregroundColor(.Courtside.textPrimary)
                }
            }
        }
        .padding(24)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.04), radius: 12, x: 0, y: 4)
        .padding(.horizontal, 24)
    }
}

public struct CheckoutCouponRow: View {
    @State private var couponCode: String = ""
    
    public var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                if couponCode.isEmpty {
                    Text("Apply Coupon / Voucher")
                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                        .foregroundColor(.Courtside.textPrimary.opacity(0.6))
                }
                TextField("", text: $couponCode)
                    .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                    .foregroundColor(.Courtside.textPrimary)
                    .autocapitalization(.allCharacters)
            }
            
            Spacer()
            
            Button(action: {
                // Apply action
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }) {
                Text("Apply")
                    .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                    .foregroundColor(couponCode.isEmpty ? .Courtside.textSecondary : .Courtside.primary)
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
        .padding(.horizontal, 24)
    }
}

public struct CheckoutWalletRow: View {
    @Binding var useWalletBalance: Bool
    
    public var body: some View {
        VStack(spacing: 16) {
            HStack {
                HStack(spacing: 12) {
                    Image(systemName: "creditcard.fill")
                        .foregroundColor(.Courtside.primary)
                    Text("Wallet Balance (₹500)")
                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                        .foregroundColor(.Courtside.textPrimary)
                }
                Spacer()
                Button(action: {
                    withAnimation {
                        useWalletBalance.toggle()
                    }
                }) {
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
            }
            
            HStack {
                Spacer()
                Button(action: {}) {
                    Text("+ Add Money")
                        .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                        .foregroundColor(.Courtside.primary)
                }
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
        .padding(.horizontal, 24)
    }
}

public struct CheckoutPaymentSummary: View {
    let basePrice: Double
    let gstAmount: Double
    let grandTotal: Double
    
    public var body: some View {
        VStack(spacing: 16) {
            Text("Payment Summary")
                .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                .foregroundColor(.Courtside.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 12) {
                HStack {
                    Text("Slot Base Price")
                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                        .foregroundColor(.Courtside.textSecondary)
                    Spacer()
                    Text(String(format: "₹%.2f", basePrice))
                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                        .foregroundColor(.Courtside.textPrimary)
                }
                
                HStack {
                    Text("GST (18%)")
                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                        .foregroundColor(.Courtside.textSecondary)
                    Spacer()
                    Text(String(format: "₹%.2f", gstAmount))
                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                        .foregroundColor(.Courtside.textPrimary)
                }
                
                Divider()
                    .padding(.vertical, 8)
                
                HStack {
                    Text("Grand Total")
                        .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                        .foregroundColor(.Courtside.textPrimary)
                    Spacer()
                    Text(String(format: "₹%.2f", grandTotal))
                        .font(.custom("PlusJakartaSans-SemiBold", size: 18))
                        .foregroundColor(.Courtside.primary)
                }
            }
        }
        .padding(24)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.04), radius: 12, x: 0, y: 4)
        .padding(.horizontal, 24)
    }
}
