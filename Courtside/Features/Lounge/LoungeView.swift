import SwiftUI

public struct LoungeView: View {
    @EnvironmentObject var cart: BookingCart
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            ZStack {
                Color.Courtside.background.ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 48) {
                        
                        // Section A: The Optimist Cafe
                        VStack(alignment: .leading, spacing: 48) {
                            
                            // Hero Logo & Description
                            VStack(spacing: 16) {
                                if let heroImage = UIImage(named: "lounge_hero.png") ?? UIImage(named: "lounge_hero") {
                                    Image(uiImage: heroImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 64)
                                        .padding(.horizontal, 40)
                                } else {
                                    Text("The Optimist")
                                        .font(.Courtside.heroDisplay)
                                        .foregroundColor(.Courtside.textPrimary)
                                }
                                
                                Text("Courtside recovery, specialty coffee, and organic nutrition.")
                                    .font(.custom("PlusJakartaSans-Italic", size: 16))
                                    .foregroundColor(.Courtside.textSecondary)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 48)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 56) // Account for safe area
                            
                            // Fine Dining Menu
                            VStack(alignment: .leading, spacing: 32) {
                                MenuRowView(
                                    title: "Post-Match Protein Smoothie",
                                    description: "Organic oats, premium whey, banana, and almond milk.",
                                    price: "₹450"
                                ) {
                                    preOrder(item: "Protein Smoothie", price: 450)
                                }
                                
                                MenuRowView(
                                    title: "Iced Oat Flat White",
                                    description: "Single-origin espresso pulled over ice with minor figures oat milk.",
                                    price: "₹320"
                                ) {
                                    preOrder(item: "Iced Oat Flat White", price: 320)
                                }
                                
                                MenuRowView(
                                    title: "Acai Recovery Bowl",
                                    description: "Frozen pure acai topped with house-made granola, berries and honey.",
                                    price: "₹650"
                                ) {
                                    preOrder(item: "Acai Bowl", price: 650)
                                }
                                
                                NavigationLink(destination: FullMenuView()) {
                                    HStack(spacing: 8) {
                                        Text("View full menu")
                                            .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                                        Image(systemName: "arrow.right")
                                            .font(.system(size: 12, weight: .bold))
                                    }
                                    .foregroundColor(.Courtside.primary)
                                    .padding(.top, 8)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                            .padding(.horizontal, 24)
                        }
                        
                        Divider()
                            .padding(.horizontal, 24)
                        
                        // Section B: Club Events
                        VStack(alignment: .leading, spacing: 0) {
                            Text("UPCOMING EVENTS")
                                .font(.custom("PlusJakartaSans-Regular", size: 14))
                                .foregroundColor(.Courtside.textSecondary)
                                .kerning(2)
                                .padding(.horizontal, 24)
                                .padding(.top, 48)
                                .padding(.bottom, 32)
                            
                            VStack(spacing: 0) {
                                EventListRow(
                                    date: "FRI, 20 JUN",
                                    time: "7:00 PM",
                                    title: "Summer Solstice Mixer",
                                    location: "The Lounge"
                                )
                                EventListRow(
                                    date: "SAT, 21 JUN",
                                    time: "5:00 PM",
                                    title: "Pro Exhibition Match",
                                    location: "Center Court"
                                )
                                EventListRow(
                                    date: "SUN, 22 JUN",
                                    time: "9:00 AM",
                                    title: "Beginner's Clinic",
                                    location: "Courts 1 & 2"
                                )
                            }
                            .padding(.bottom, 120) // Give plenty of room for global checkout pill
                        }
                        .background(Color.Courtside.textSecondary.opacity(0.04))
                    }
                }
                .ignoresSafeArea(edges: .top)
            }
            .navigationBarHidden(true)
        }
    }
    
    private func preOrder(item: String, price: Double) {
        // Create a dummy court and date for the cart item since it's a food item
        let dummyCourt = Court(id: UUID().uuidString, name: item)
        // We'll create a special selected slot for pre-orders
        let slot = SelectedSlot(
            date: Date(),
            timeString: "Pre-order",
            court: dummyCourt,
            category: .recovery
        )
        withAnimation {
            cart.add(slot)
        }
    }
}

// MARK: - Components

public struct MenuRowView: View {
    let title: String
    let description: String
    let price: String
    let onAdd: () -> Void
    
    public var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // Left Column: Content
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                    .foregroundColor(.Courtside.textPrimary)
                
                Text(description)
                    .font(.custom("PlusJakartaSans-Regular", size: 14))
                    .foregroundColor(.Courtside.textSecondary)
                    .lineLimit(2)
                    
                Text(price)
                    .font(.custom("PlusJakartaSans-SemiBold", size: 15))
                    .foregroundColor(.Courtside.primary)
                    .padding(.top, 2)
            }
            
            Spacer()
            
            // Right Column: Action
            Button(action: onAdd) {
                Text("Add")
                    .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                    .foregroundColor(.Courtside.primary)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .overlay(
                        Capsule()
                            .stroke(Color.Courtside.primary.opacity(0.3), lineWidth: 1)
                    )
            }
        }
    }
}

public struct EventListRow: View {
    let date: String
    let time: String
    let title: String
    let location: String
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 24) {
                // Date & Time Column
                VStack(alignment: .leading, spacing: 4) {
                    Text(date)
                        .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                        .foregroundColor(.Courtside.primary)
                    Text(time)
                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                        .foregroundColor(.Courtside.textSecondary)
                }
                .frame(width: 100, alignment: .leading)
                
                // Details Column
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.custom("PlusJakartaSans-Regular", size: 20))
                        .foregroundColor(.Courtside.textPrimary)
                        .lineLimit(2)
                    
                    HStack(spacing: 6) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 12))
                        Text(location)
                            .font(.custom("PlusJakartaSans-Regular", size: 14))
                    }
                    .foregroundColor(.Courtside.textSecondary)
                }
                
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 24)
            
            Divider()
                .padding(.horizontal, 24)
        }
    }
}

// MARK: - Full Menu Wireframe

public struct FullMenuView: View {
    @Environment(\.presentationMode) var presentationMode
    
    public var body: some View {
        ZStack {
            Color.Courtside.background.ignoresSafeArea()
            
            VStack(spacing: 24) {
                if let heroImage = UIImage(named: "lounge_hero.png") ?? UIImage(named: "lounge_hero") {
                    Image(uiImage: heroImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 64)
                        .padding(.horizontal, 40)
                } else {
                    Text("The Optimist")
                        .font(.Courtside.heroDisplay)
                        .foregroundColor(.Courtside.textPrimary)
                }
                
                Text("Full menu data incoming...")
                    .font(.custom("PlusJakartaSans-Regular", size: 16))
                    .foregroundColor(.Courtside.textSecondary)
                
                Spacer()
            }
            .padding(.top, 40)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.Courtside.textPrimary)
                        .padding(8) // Increased hit area
                        .contentShape(Rectangle())
                }
            }
        }
    }
}
