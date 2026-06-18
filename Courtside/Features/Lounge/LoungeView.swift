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
    let description: String?
    let price: String
    let onAdd: () -> Void
    
    public var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // Left Column: Content
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                    .foregroundColor(.Courtside.textPrimary)
                
                if let desc = description {
                    Text(desc)
                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                        .foregroundColor(.Courtside.textSecondary)
                        .lineLimit(2)
                }
                    
                Text(price)
                    .font(.custom("PlusJakartaSans-SemiBold", size: 15))
                    .foregroundColor(.Courtside.primary)
                    .padding(.top, 2)
            }
            
            Spacer()
            
            // Right Column: Action
            Button(action: onAdd) {
                HStack(spacing: 4) {
                    Image(systemName: "plus")
                        .font(.system(size: 10, weight: .bold))
                    Text("ADD")
                        .font(.custom("PlusJakartaSans-Bold", size: 11))
                        .kerning(1)
                }
                .foregroundColor(.Courtside.primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.Courtside.primary.opacity(0.08))
                .clipShape(Capsule())
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

// MARK: - Full Menu Data Models

struct MenuItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String?
    let price: String
}

struct MenuSection: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String?
    let items: [MenuItem]
    let isSpecial: Bool
}

let fullMenuData: [MenuSection] = [
    MenuSection(title: "HEALTHY BOWLS", subtitle: "Available 7:00am – 11:30am & 4:00pm – 10:00pm", items: [
        MenuItem(title: "Granola & Yoghurt", description: "Vanilla Greek yoghurt, house-made granola, seasonal fruit, wildflower honey", price: "₹550"),
        MenuItem(title: "Green Goddess Smoothie Bowl", description: "Avocado, ceremonial matcha, mango, banana, toasted seeds, fresh berries", price: "₹650"),
        MenuItem(title: "Add Performance Plant Protein", description: "(22g protein)", price: "₹200"),
        MenuItem(title: "Banoffee Overnight Oats", description: "Gluten-free oats, almond milk, banana, date caramel, cacao nibs", price: "₹500"),
        MenuItem(title: "Cinnamon Crunch Oats", description: "Warm vanilla oats, roasted almonds, cinnamon crumble", price: "₹380"),
        MenuItem(title: "Acai Recovery Bowl", description: "Organic acai, mixed berries, banana, coconut flakes, chia seeds", price: "₹690"),
        MenuItem(title: "Athlete Power Bowl", description: "Greek yoghurt, granola, berries, almond butter, honey, hemp seeds", price: "₹750")
    ], isSpecial: false),
    
    MenuSection(title: "MATCHA BAR", subtitle: "Available All Day", items: [
        MenuItem(title: "Ceremonial Matcha", description: "Premium Japanese ceremonial grade matcha", price: "₹320"),
        MenuItem(title: "Matcha Latte", description: "Choice of dairy, oat, almond, or coconut milk", price: "₹380"),
        MenuItem(title: "Vanilla Matcha Cloud", description: "Ceremonial matcha, vanilla bean, oat milk", price: "₹420"),
        MenuItem(title: "Strawberry Matcha", description: "Fresh strawberry puree layered with ceremonial matcha", price: "₹450"),
        MenuItem(title: "Coconut Matcha Cooler", description: "Matcha, coconut water, lime", price: "₹480"),
        MenuItem(title: "Matcha Protein Shake", description: "Matcha, banana, vanilla protein, almond milk", price: "₹550"),
        MenuItem(title: "Iced Yuzu Matcha", description: "Japanese yuzu citrus, ceremonial matcha, sparkling water", price: "₹490"),
        MenuItem(title: "Matcha Affogato", description: "Ceremonial matcha poured over vanilla gelato", price: "₹520")
    ], isSpecial: false),
    
    MenuSection(title: "SPECIALTY COFFEE", subtitle: "Available All Day", items: [
        MenuItem(title: "Espresso", description: nil, price: "₹220"),
        MenuItem(title: "Cortado", description: nil, price: "₹280"),
        MenuItem(title: "Flat White", description: nil, price: "₹320"),
        MenuItem(title: "Cappuccino", description: nil, price: "₹320"),
        MenuItem(title: "Café Latte", description: nil, price: "₹340"),
        MenuItem(title: "Spanish Latte", description: "Condensed milk, double espresso", price: "₹390"),
        MenuItem(title: "Vanilla Bean Latte", description: "Madagascar vanilla, espresso, steamed milk", price: "₹420"),
        MenuItem(title: "Honey Cinnamon Latte", description: "Wildflower honey, cinnamon, double espresso", price: "₹430"),
        MenuItem(title: "Pistachio Latte", description: "House pistachio cream, espresso", price: "₹480"),
        MenuItem(title: "Cold Brew", description: "18-hour slow brewed coffee", price: "₹380"),
        MenuItem(title: "Nitro Cold Brew", description: "Velvety nitrogen-infused cold brew", price: "₹450"),
        MenuItem(title: "Athlete Protein Coffee", description: "Double espresso, vanilla protein, almond milk", price: "₹550")
    ], isSpecial: false),
    
    MenuSection(title: "EGGS", subtitle: "Available 4:00pm – 10:00pm. Please allow 15 minutes preparation time.", items: [
        MenuItem(title: "Scrambled Eggs", description: "Three eggs, chives, brioche, mushrooms", price: "₹450"),
        MenuItem(title: "French Omelette", description: "Three eggs, herbs, brioche, mushrooms", price: "₹450"),
        MenuItem(title: "Truffle Scramble", description: "Soft scrambled eggs, truffle oil, sourdough", price: "₹690"),
        MenuItem(title: "Smoked Salmon Omelette", description: "Three eggs, smoked salmon, cream cheese", price: "₹780"),
        MenuItem(title: "Athlete Egg White Omelette", description: "Egg whites, spinach, herbs, avocado", price: "₹620")
    ], isSpecial: false),
    
    MenuSection(title: "PERFORMANCE TOASTS", subtitle: nil, items: [
        MenuItem(title: "Avocado Smash", description: "Sourdough, avocado, feta, microgreens", price: "₹620"),
        MenuItem(title: "Truffle Mushroom Toast", description: "Wild mushrooms, truffle cream, sourdough", price: "₹680"),
        MenuItem(title: "Smoked Salmon Toast", description: "Avocado, smoked salmon, capers", price: "₹820"),
        MenuItem(title: "Burrata Toast", description: "Burrata, heirloom tomatoes, basil oil", price: "₹760")
    ], isSpecial: false),
    
    MenuSection(title: "RECOVERY SHAKES", subtitle: nil, items: [
        MenuItem(title: "Vanilla Recovery Shake", description: "Vanilla protein, banana, almond milk", price: "₹520"),
        MenuItem(title: "Chocolate Performance Shake", description: "Chocolate protein, dates, peanut butter", price: "₹550"),
        MenuItem(title: "Berry Recovery Blend", description: "Mixed berries, yoghurt, honey", price: "₹580"),
        MenuItem(title: "Green Fuel Shake", description: "Spinach, avocado, pineapple, coconut water", price: "₹580")
    ], isSpecial: false),
    
    MenuSection(title: "DESSERTS", subtitle: "Available 4:00pm – 10:00pm", items: [
        MenuItem(title: "Gluten-Free Orange Almond Cake", description: nil, price: "₹450"),
        MenuItem(title: "Burnt Basque Cheesecake", description: nil, price: "₹620"),
        MenuItem(title: "Dark Chocolate Protein Cake", description: nil, price: "₹580"),
        MenuItem(title: "Flourless Chocolate Torte", description: nil, price: "₹650")
    ], isSpecial: false),
    
    MenuSection(title: "MONTHLY SPECIALS", subtitle: nil, items: [
        MenuItem(title: "Protein Brookie", description: "Brownie meets cookie, high-protein edition", price: "₹280"),
        MenuItem(title: "Miso Millionaire Sticks", description: "Salted miso caramel, dark chocolate", price: "₹280"),
        MenuItem(title: "Matcha Tiramisu", description: "Ceremonial matcha, mascarpone cream", price: "₹520"),
        MenuItem(title: "Dubai Pistachio Cookie", description: "Pistachio cream-filled luxury cookie", price: "₹380"),
        MenuItem(title: "Athlete's Chocolate Tart", description: "Dark chocolate, sea salt, protein mousse", price: "₹550")
    ], isSpecial: true)
]

// MARK: - Full Menu Implementation

public struct FullMenuView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var cart: BookingCart
    
    public var body: some View {
        ZStack {
            Color.Courtside.background.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    // Header Logo
                    if let heroImage = UIImage(named: "lounge_hero.png") ?? UIImage(named: "lounge_hero") {
                        Image(uiImage: heroImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 64)
                            .padding(.horizontal, 40)
                            .padding(.top, 40)
                            .padding(.bottom, 64)
                    } else {
                        Text("The Optimist")
                            .font(.Courtside.heroDisplay)
                            .foregroundColor(.Courtside.textPrimary)
                            .padding(.top, 40)
                            .padding(.bottom, 64)
                    }
                    
                    // Sections
                    VStack(spacing: 64) {
                        ForEach(fullMenuData) { section in
                            VStack(alignment: .leading, spacing: 32) {
                                
                                // Section Header
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(section.title)
                                        .font(.custom("PlusJakartaSans-SemiBold", size: 18))
                                        .foregroundColor(.Courtside.textPrimary)
                                        .kerning(2)
                                    
                                    if let subtitle = section.subtitle {
                                        Text(subtitle)
                                            .font(.custom("PlusJakartaSans-Italic", size: 13))
                                            .foregroundColor(.Courtside.textSecondary)
                                    }
                                }
                                .padding(.horizontal, section.isSpecial ? 24 : 0)
                                
                                // Items
                                VStack(spacing: 32) {
                                    ForEach(section.items) { item in
                                        MenuRowView(
                                            title: item.title,
                                            description: item.description,
                                            price: item.price
                                        ) {
                                            let dummyCourt = Court(id: UUID().uuidString, name: item.title)
                                            let slot = SelectedSlot(
                                                date: Date(),
                                                timeString: "Pre-order",
                                                court: dummyCourt,
                                                category: .recovery
                                            )
                                            withAnimation { cart.add(slot) }
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
                    
                    // Footer Fine Print
                    VStack(spacing: 32) {
                        // Delicate Divider
                        Rectangle()
                            .fill(Color.Courtside.textSecondary.opacity(0.2))
                            .frame(width: 32, height: 1)
                        
                        // Disclaimer Paragraph
                        Text("Service charge and applicable taxes are additional. All ingredients are sourced from premium suppliers and prepared fresh daily. Please inform our team of any allergies or dietary requirements.")
                            .font(.custom("PlusJakartaSans-Regular", size: 11))
                            .foregroundColor(.Courtside.textSecondary.opacity(0.6))
                            .lineSpacing(6)
                        
                        // The Sign-off
                        VStack(spacing: 8) {
                            Image(systemName: "diamond.fill")
                                .font(.system(size: 6))
                                .foregroundColor(.Courtside.textSecondary.opacity(0.3))
                            
                            Text("Designed for performance, recovery,\nand elevated social dining.")
                                .font(.custom("PlusJakartaSans-Italic", size: 11))
                                .foregroundColor(.Courtside.textSecondary.opacity(0.8))
                                .kerning(0.5)
                        }
                    }
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 48)
                    .padding(.top, 64)
                    .padding(.bottom, 80)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.Courtside.textPrimary)
                        .padding(8)
                        .contentShape(Rectangle())
                }
            }
        }
    }
}
