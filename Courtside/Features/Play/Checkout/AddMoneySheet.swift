import SwiftUI

public struct AddMoneySheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedAmount: Int? = nil
    @State private var added = false

    private let presets = [500, 1000, 2000, 5000]

    public var body: some View {
        ZStack {
            Color.Courtside.background.ignoresSafeArea()

            VStack(spacing: 0) {
                Capsule()
                    .fill(Color.Courtside.textSecondary.opacity(0.2))
                    .frame(width: 40, height: 4)
                    .padding(.top, 12)

                VStack(alignment: .leading, spacing: 40) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Add to Wallet")
                            .font(.Courtside.heroDisplay)
                            .foregroundStyle(.Courtside.textPrimary)

                        Text("Funds are credited instantly.")
                            .font(.custom("PlusJakartaSans-Regular", size: 16))
                            .foregroundStyle(.Courtside.textSecondary)
                    }
                    .padding(.top, 32)

                    VStack(alignment: .leading, spacing: 16) {
                        Text("SELECT AMOUNT")
                            .font(.custom("PlusJakartaSans-Regular", size: 11))
                            .foregroundStyle(.Courtside.textSecondary)
                            .kerning(1.2)

                        HStack(spacing: 12) {
                            ForEach(presets, id: \.self) { amount in
                                Button {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        selectedAmount = amount
                                    }
                                } label: {
                                    Text("₹\(amount)")
                                        .font(.custom("PlusJakartaSans-SemiBold", size: 15))
                                        .foregroundStyle(selectedAmount == amount ? .white : .Courtside.textPrimary)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 14)
                                        .background(selectedAmount == amount ? Color.Courtside.primary : Color.Courtside.textSecondary.opacity(0.06))
                                        .clipShape(.capsule)
                                }
                            }
                        }
                    }

                    if added {
                        HStack(spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                            if let amount = selectedAmount {
                                Text("₹\(amount) added to your wallet")
                                    .font(.custom("PlusJakartaSans-SemiBold", size: 15))
                                    .foregroundStyle(.Courtside.textPrimary)
                            }
                        }
                        .padding(20)
                        .background(Color.green.opacity(0.08))
                        .clipShape(.rect(cornerRadius: 16))
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }

                    Spacer()

                    PrimaryButton(title: added ? "Added" : "Add to Wallet") {
                        withAnimation { added = true }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { dismiss() }
                    }
                    .disabled(selectedAmount == nil || added)
                    .padding(.bottom, 48)
                }
                .padding(.horizontal, 32)
            }
        }
    }
}
