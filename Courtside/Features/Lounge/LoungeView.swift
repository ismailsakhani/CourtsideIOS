import SwiftUI

public struct LoungeView: View {
    @EnvironmentObject var cart: BookingCart
    @State private var selectedDish: MenuItem?
    
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
                                let item1 = fullMenuData[5].items[1]
                                MenuRowView(
                                    title: item1.title,
                                    description: item1.description,
                                    price: item1.price,
                                    onRowTapped: { selectedDish = item1 }
                                ) {
                                    selectedDish = item1
                                }
                                
                                let item2 = fullMenuData[2].items[2]
                                MenuRowView(
                                    title: item2.title,
                                    description: item2.description,
                                    price: item2.price,
                                    onRowTapped: { selectedDish = item2 }
                                ) {
                                    selectedDish = item2
                                }
                                
                                let item3 = fullMenuData[0].items[5]
                                MenuRowView(
                                    title: item3.title,
                                    description: item3.description,
                                    price: item3.price,
                                    onRowTapped: { selectedDish = item3 }
                                ) {
                                    selectedDish = item3
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
                                
                                NavigationLink(destination: AllEventsView()) {
                                    HStack(spacing: 8) {
                                        Text("View all events")
                                            .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                                        Image(systemName: "arrow.right")
                                            .font(.system(size: 12, weight: .bold))
                                    }
                                    .foregroundColor(.Courtside.primary)
                                    .padding(.top, 32)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                }
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
        .sheet(item: $selectedDish) { dish in
            DishDetailSheet(dish: dish) {
                let dummyCourt = Court(id: UUID().uuidString, name: dish.title)
                let slot = SelectedSlot(
                    date: Date(),
                    timeString: "Pre-order",
                    court: dummyCourt,
                    category: .recovery
                )
                withAnimation { cart.add(slot) }
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
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
    let onRowTapped: () -> Void
    let onAdd: () -> Void
    
    public var body: some View {
        Button(action: onRowTapped) {
            HStack(alignment: .center, spacing: 16) {
                // Thumbnail Placeholder
                Rectangle()
                    .fill(Color.Courtside.textSecondary.opacity(0.06))
                    .frame(width: 72, height: 72)
                    .overlay(
                        Image(systemName: "camera.macro")
                            .font(.system(size: 16))
                            .foregroundColor(.Courtside.textSecondary.opacity(0.3))
                    )
                    .cornerRadius(8)
                
                // Content Column
                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                        .foregroundColor(.Courtside.textPrimary)
                        .multilineTextAlignment(.leading)
                    
                    if let desc = description {
                        Text(desc)
                            .font(.custom("PlusJakartaSans-Regular", size: 14))
                            .foregroundColor(.Courtside.textSecondary)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                    }
                    
                    HStack(alignment: .bottom, spacing: 12) {
                        Text(price)
                            .font(.custom("PlusJakartaSans-SemiBold", size: 15))
                            .foregroundColor(.Courtside.primary)
                        
                        Text("VIEW DETAILS")
                            .font(.custom("PlusJakartaSans-SemiBold", size: 9))
                            .foregroundColor(.Courtside.textSecondary.opacity(0.6))
                            .kerning(1)
                            .padding(.bottom, 2)
                    }
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
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
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

public struct MenuMacros {
    let calories: String
    let protein: String
    let carbs: String
    let fats: String
}

struct MenuItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String?
    let price: String
    let ingredients: [String]
    let macros: MenuMacros
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
        MenuItem(title: "Granola & Yoghurt", description: "Vanilla Greek yoghurt, house-made granola, seasonal fruit, wildflower honey", price: "₹550", ingredients: ["Vanilla Greek Yoghurt", "House-made Oat & Pecan Granola", "Seasonal Berries", "Wildflower Honey", "Chia Seeds"], macros: MenuMacros(calories: "380 kcal", protein: "14g", carbs: "42g", fats: "16g")),
        MenuItem(title: "Green Goddess Smoothie Bowl", description: "Avocado, ceremonial matcha, mango, banana, toasted seeds, fresh berries", price: "₹650", ingredients: ["Hass Avocado", "Ceremonial Grade Matcha", "Alphonso Mango", "Banana", "Toasted Pumpkin Seeds", "Fresh Raspberries"], macros: MenuMacros(calories: "410 kcal", protein: "8g", carbs: "54g", fats: "22g")),
        MenuItem(title: "Add Performance Plant Protein", description: "(22g protein)", price: "₹200", ingredients: ["Pea Protein Isolate", "Brown Rice Protein", "Hemp Seed Powder"], macros: MenuMacros(calories: "120 kcal", protein: "22g", carbs: "4g", fats: "2g")),
        MenuItem(title: "Banoffee Overnight Oats", description: "Gluten-free oats, almond milk, banana, date caramel, cacao nibs", price: "₹500", ingredients: ["Gluten-Free Rolled Oats", "Unsweetened Almond Milk", "Banana", "Medjool Date Caramel", "Raw Cacao Nibs", "Maca Powder"], macros: MenuMacros(calories: "450 kcal", protein: "12g", carbs: "68g", fats: "14g")),
        MenuItem(title: "Cinnamon Crunch Oats", description: "Warm vanilla oats, roasted almonds, cinnamon crumble", price: "₹380", ingredients: ["Steel Cut Oats", "Madagascar Vanilla", "Roasted Almonds", "Ceylon Cinnamon", "Coconut Sugar Crumble"], macros: MenuMacros(calories: "320 kcal", protein: "10g", carbs: "45g", fats: "12g")),
        MenuItem(title: "Acai Recovery Bowl", description: "Organic acai, mixed berries, banana, coconut flakes, chia seeds", price: "₹690", ingredients: ["Organic Amazonian Acai", "Mixed Berries", "Banana", "Toasted Coconut Flakes", "Chia Seeds", "Agave Nectar"], macros: MenuMacros(calories: "390 kcal", protein: "6g", carbs: "62g", fats: "18g")),
        MenuItem(title: "Athlete Power Bowl", description: "Greek yoghurt, granola, berries, almond butter, honey, hemp seeds", price: "₹750", ingredients: ["0% Greek Yoghurt", "Grain-Free Granola", "Fresh Blueberries", "Artisan Almond Butter", "Raw Honey", "Hemp Hearts"], macros: MenuMacros(calories: "520 kcal", protein: "26g", carbs: "48g", fats: "28g"))
    ], isSpecial: false),
    
    MenuSection(title: "MATCHA BAR", subtitle: "Available All Day", items: [
        MenuItem(title: "Ceremonial Matcha", description: "Premium Japanese ceremonial grade matcha", price: "₹320", ingredients: ["Ceremonial Grade Uji Matcha", "Filtered Hot Water"], macros: MenuMacros(calories: "10 kcal", protein: "1g", carbs: "1g", fats: "0g")),
        MenuItem(title: "Matcha Latte", description: "Choice of dairy, oat, almond, or coconut milk", price: "₹380", ingredients: ["Ceremonial Grade Matcha", "Choice of Milk", "Optional Agave"], macros: MenuMacros(calories: "120 kcal", protein: "4g", carbs: "12g", fats: "6g")),
        MenuItem(title: "Vanilla Matcha Cloud", description: "Ceremonial matcha, vanilla bean, oat milk", price: "₹420", ingredients: ["Ceremonial Grade Matcha", "Madagascar Vanilla Bean Paste", "Oat Milk", "Stevia"], macros: MenuMacros(calories: "140 kcal", protein: "3g", carbs: "18g", fats: "7g")),
        MenuItem(title: "Strawberry Matcha", description: "Fresh strawberry puree layered with ceremonial matcha", price: "₹450", ingredients: ["Ceremonial Grade Matcha", "House-Made Strawberry Puree", "Oat Milk"], macros: MenuMacros(calories: "160 kcal", protein: "3g", carbs: "24g", fats: "6g")),
        MenuItem(title: "Coconut Matcha Cooler", description: "Matcha, coconut water, lime", price: "₹480", ingredients: ["Ceremonial Grade Matcha", "100% Pure Coconut Water", "Fresh Lime Juice"], macros: MenuMacros(calories: "60 kcal", protein: "1g", carbs: "14g", fats: "0g")),
        MenuItem(title: "Matcha Protein Shake", description: "Matcha, banana, vanilla protein, almond milk", price: "₹550", ingredients: ["Ceremonial Grade Matcha", "Banana", "Vanilla Whey or Plant Protein", "Almond Milk"], macros: MenuMacros(calories: "280 kcal", protein: "25g", carbs: "32g", fats: "6g")),
        MenuItem(title: "Iced Yuzu Matcha", description: "Japanese yuzu citrus, ceremonial matcha, sparkling water", price: "₹490", ingredients: ["Ceremonial Grade Matcha", "Yuzu Extract", "Sparkling Water", "Mint"], macros: MenuMacros(calories: "25 kcal", protein: "1g", carbs: "5g", fats: "0g")),
        MenuItem(title: "Matcha Affogato", description: "Ceremonial matcha poured over vanilla gelato", price: "₹520", ingredients: ["Ceremonial Grade Matcha", "Artisanal Vanilla Bean Gelato"], macros: MenuMacros(calories: "210 kcal", protein: "5g", carbs: "26g", fats: "10g"))
    ], isSpecial: false),
    
    MenuSection(title: "SPECIALTY COFFEE", subtitle: "Available All Day", items: [
        MenuItem(title: "Espresso", description: nil, price: "₹220", ingredients: ["Single Origin Arabica Beans"], macros: MenuMacros(calories: "5 kcal", protein: "0g", carbs: "1g", fats: "0g")),
        MenuItem(title: "Cortado", description: nil, price: "₹280", ingredients: ["Double Espresso", "Steamed Milk (Equal Parts)"], macros: MenuMacros(calories: "60 kcal", protein: "4g", carbs: "6g", fats: "3g")),
        MenuItem(title: "Flat White", description: nil, price: "₹320", ingredients: ["Double Espresso Ristretto", "Microfoamed Milk"], macros: MenuMacros(calories: "110 kcal", protein: "6g", carbs: "10g", fats: "5g")),
        MenuItem(title: "Cappuccino", description: nil, price: "₹320", ingredients: ["Double Espresso", "Steamed Milk", "Heavy Foam"], macros: MenuMacros(calories: "120 kcal", protein: "7g", carbs: "11g", fats: "6g")),
        MenuItem(title: "Café Latte", description: nil, price: "₹340", ingredients: ["Single Espresso", "Steamed Milk", "Light Foam"], macros: MenuMacros(calories: "150 kcal", protein: "8g", carbs: "14g", fats: "7g")),
        MenuItem(title: "Spanish Latte", description: "Condensed milk, double espresso", price: "₹390", ingredients: ["Double Espresso", "Steamed Milk", "Sweetened Condensed Milk"], macros: MenuMacros(calories: "260 kcal", protein: "8g", carbs: "38g", fats: "9g")),
        MenuItem(title: "Vanilla Bean Latte", description: "Madagascar vanilla, espresso, steamed milk", price: "₹420", ingredients: ["Double Espresso", "Steamed Milk", "Madagascar Vanilla Syrup"], macros: MenuMacros(calories: "210 kcal", protein: "7g", carbs: "28g", fats: "7g")),
        MenuItem(title: "Honey Cinnamon Latte", description: "Wildflower honey, cinnamon, double espresso", price: "₹430", ingredients: ["Double Espresso", "Steamed Milk", "Wildflower Honey", "Ceylon Cinnamon"], macros: MenuMacros(calories: "190 kcal", protein: "7g", carbs: "24g", fats: "7g")),
        MenuItem(title: "Pistachio Latte", description: "House pistachio cream, espresso", price: "₹480", ingredients: ["Double Espresso", "Steamed Oat Milk", "House-Made Pistachio Cream"], macros: MenuMacros(calories: "280 kcal", protein: "6g", carbs: "32g", fats: "14g")),
        MenuItem(title: "Cold Brew", description: "18-hour slow brewed coffee", price: "₹380", ingredients: ["18-Hour Steeped Arabica Blend", "Filtered Water", "Ice"], macros: MenuMacros(calories: "5 kcal", protein: "0g", carbs: "1g", fats: "0g")),
        MenuItem(title: "Nitro Cold Brew", description: "Velvety nitrogen-infused cold brew", price: "₹450", ingredients: ["Cold Brew Coffee", "Nitrogen Gas Infusion"], macros: MenuMacros(calories: "5 kcal", protein: "0g", carbs: "1g", fats: "0g")),
        MenuItem(title: "Athlete Protein Coffee", description: "Double espresso, vanilla protein, almond milk", price: "₹550", ingredients: ["Double Espresso", "Vanilla Whey Isolate", "Unsweetened Almond Milk", "Ice"], macros: MenuMacros(calories: "140 kcal", protein: "26g", carbs: "4g", fats: "3g"))
    ], isSpecial: false),
    
    MenuSection(title: "EGGS", subtitle: "Available 4:00pm – 10:00pm. Please allow 15 minutes preparation time.", items: [
        MenuItem(title: "Scrambled Eggs", description: "Three eggs, chives, brioche, mushrooms", price: "₹450", ingredients: ["Three Free-Range Eggs", "French Butter", "Chives", "Toasted Brioche", "Roasted Wild Mushrooms"], macros: MenuMacros(calories: "480 kcal", protein: "24g", carbs: "28g", fats: "32g")),
        MenuItem(title: "French Omelette", description: "Three eggs, herbs, brioche, mushrooms", price: "₹450", ingredients: ["Three Free-Range Eggs", "Fines Herbes", "French Butter", "Toasted Brioche", "Roasted Wild Mushrooms"], macros: MenuMacros(calories: "480 kcal", protein: "24g", carbs: "28g", fats: "32g")),
        MenuItem(title: "Truffle Scramble", description: "Soft scrambled eggs, truffle oil, sourdough", price: "₹690", ingredients: ["Three Free-Range Eggs", "Black Truffle Oil", "Shaved Winter Truffle", "Toasted Sourdough"], macros: MenuMacros(calories: "450 kcal", protein: "22g", carbs: "30g", fats: "28g")),
        MenuItem(title: "Smoked Salmon Omelette", description: "Three eggs, smoked salmon, cream cheese", price: "₹780", ingredients: ["Three Free-Range Eggs", "Norwegian Smoked Salmon", "Whipped Cream Cheese", "Dill", "Capers"], macros: MenuMacros(calories: "520 kcal", protein: "38g", carbs: "4g", fats: "38g")),
        MenuItem(title: "Athlete Egg White Omelette", description: "Egg whites, spinach, herbs, avocado", price: "₹620", ingredients: ["Five Egg Whites", "Baby Spinach", "Parsley", "Half Hass Avocado", "Cherry Tomatoes"], macros: MenuMacros(calories: "280 kcal", protein: "24g", carbs: "12g", fats: "15g"))
    ], isSpecial: false),
    
    MenuSection(title: "PERFORMANCE TOASTS", subtitle: nil, items: [
        MenuItem(title: "Avocado Smash", description: "Sourdough, avocado, feta, microgreens", price: "₹620", ingredients: ["Artisan Sourdough", "Hass Avocado", "Greek Feta", "Radish Microgreens", "Chili Flakes", "Lemon Juice"], macros: MenuMacros(calories: "420 kcal", protein: "12g", carbs: "38g", fats: "26g")),
        MenuItem(title: "Truffle Mushroom Toast", description: "Wild mushrooms, truffle cream, sourdough", price: "₹680", ingredients: ["Artisan Sourdough", "Mixed Wild Mushrooms", "Truffle Ricotta Cream", "Thyme"], macros: MenuMacros(calories: "380 kcal", protein: "14g", carbs: "36g", fats: "20g")),
        MenuItem(title: "Smoked Salmon Toast", description: "Avocado, smoked salmon, capers", price: "₹820", ingredients: ["Artisan Sourdough", "Hass Avocado Smash", "Norwegian Smoked Salmon", "Capers", "Red Onion", "Dill"], macros: MenuMacros(calories: "490 kcal", protein: "26g", carbs: "39g", fats: "28g")),
        MenuItem(title: "Burrata Toast", description: "Burrata, heirloom tomatoes, basil oil", price: "₹760", ingredients: ["Artisan Sourdough", "Fresh Italian Burrata", "Heirloom Tomatoes", "Basil Infused Olive Oil", "Balsamic Glaze"], macros: MenuMacros(calories: "510 kcal", protein: "18g", carbs: "42g", fats: "30g"))
    ], isSpecial: false),
    
    MenuSection(title: "RECOVERY SHAKES", subtitle: nil, items: [
        MenuItem(title: "Vanilla Recovery Shake", description: "Vanilla protein, banana, almond milk", price: "₹520", ingredients: ["Vanilla Whey Isolate (25g)", "Banana", "Unsweetened Almond Milk", "Ice"], macros: MenuMacros(calories: "220 kcal", protein: "26g", carbs: "24g", fats: "3g")),
        MenuItem(title: "Chocolate Performance Shake", description: "Chocolate protein, dates, peanut butter", price: "₹550", ingredients: ["Chocolate Whey Isolate (25g)", "Medjool Dates", "Organic Peanut Butter", "Oat Milk", "Cacao Powder"], macros: MenuMacros(calories: "410 kcal", protein: "32g", carbs: "45g", fats: "14g")),
        MenuItem(title: "Berry Recovery Blend", description: "Mixed berries, yoghurt, honey", price: "₹580", ingredients: ["Vanilla Whey Isolate (25g)", "Mixed Berries", "Greek Yoghurt", "Raw Honey", "Coconut Water"], macros: MenuMacros(calories: "320 kcal", protein: "30g", carbs: "42g", fats: "4g")),
        MenuItem(title: "Green Fuel Shake", description: "Spinach, avocado, pineapple, coconut water", price: "₹580", ingredients: ["Plant Protein (20g)", "Baby Spinach", "Avocado", "Pineapple", "Coconut Water", "Lime"], macros: MenuMacros(calories: "340 kcal", protein: "24g", carbs: "38g", fats: "12g"))
    ], isSpecial: false),
    
    MenuSection(title: "DESSERTS", subtitle: "Available 4:00pm – 10:00pm", items: [
        MenuItem(title: "Gluten-Free Orange Almond Cake", description: nil, price: "₹450", ingredients: ["Almond Flour", "Whole Oranges", "Free-Range Eggs", "Coconut Sugar", "Flaked Almonds"], macros: MenuMacros(calories: "380 kcal", protein: "10g", carbs: "32g", fats: "24g")),
        MenuItem(title: "Burnt Basque Cheesecake", description: nil, price: "₹620", ingredients: ["Cream Cheese", "Heavy Cream", "Free-Range Eggs", "Cane Sugar", "Vanilla Bean"], macros: MenuMacros(calories: "490 kcal", protein: "8g", carbs: "28g", fats: "38g")),
        MenuItem(title: "Dark Chocolate Protein Cake", description: nil, price: "₹580", ingredients: ["70% Dark Chocolate", "Chocolate Whey Isolate", "Almond Flour", "Greek Yoghurt", "Stevia"], macros: MenuMacros(calories: "310 kcal", protein: "22g", carbs: "24g", fats: "16g")),
        MenuItem(title: "Flourless Chocolate Torte", description: nil, price: "₹650", ingredients: ["70% Single Origin Dark Chocolate", "French Butter", "Free-Range Eggs", "Cane Sugar", "Sea Salt"], macros: MenuMacros(calories: "460 kcal", protein: "6g", carbs: "34g", fats: "34g"))
    ], isSpecial: false),
    
    MenuSection(title: "MONTHLY SPECIALS", subtitle: nil, items: [
        MenuItem(title: "Protein Brookie", description: "Brownie meets cookie, high-protein edition", price: "₹280", ingredients: ["Almond Flour", "Chocolate Whey Isolate", "Dark Chocolate Chips", "Coconut Oil", "Monk Fruit Sweetener"], macros: MenuMacros(calories: "240 kcal", protein: "16g", carbs: "18g", fats: "14g")),
        MenuItem(title: "Miso Millionaire Sticks", description: "Salted miso caramel, dark chocolate", price: "₹280", ingredients: ["Almond Flour Shortbread", "White Miso Caramel", "70% Dark Chocolate Coating", "Flaky Sea Salt"], macros: MenuMacros(calories: "280 kcal", protein: "4g", carbs: "32g", fats: "16g")),
        MenuItem(title: "Matcha Tiramisu", description: "Ceremonial matcha, mascarpone cream", price: "₹520", ingredients: ["Mascarpone Cheese", "Ladyfingers", "Ceremonial Grade Matcha", "Free-Range Eggs", "Cane Sugar"], macros: MenuMacros(calories: "410 kcal", protein: "8g", carbs: "42g", fats: "26g")),
        MenuItem(title: "Dubai Pistachio Cookie", description: "Pistachio cream-filled luxury cookie", price: "₹380", ingredients: ["Brown Butter Cookie Dough", "Roasted Pistachio Cream Center", "White Chocolate Chunks", "Crushed Pistachios"], macros: MenuMacros(calories: "440 kcal", protein: "6g", carbs: "52g", fats: "24g")),
        MenuItem(title: "Athlete's Chocolate Tart", description: "Dark chocolate, sea salt, protein mousse", price: "₹550", ingredients: ["Almond & Date Crust", "Silken Tofu & Chocolate Protein Mousse", "70% Dark Chocolate Ganache", "Maldon Sea Salt"], macros: MenuMacros(calories: "360 kcal", protein: "18g", carbs: "28g", fats: "22g"))
    ], isSpecial: true)
]

// MARK: - Full Menu Implementation

public struct FullMenuView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var cart: BookingCart
    @State private var selectedDish: MenuItem?
    
    public var body: some View {
        ZStack {
            Color.Courtside.background.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    // Header
                    HStack {
                        Text("MENU")
                            .font(.Courtside.heroDisplay)
                            .foregroundColor(.Courtside.textPrimary)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 40)
                    .padding(.bottom, 64)
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
                                            price: item.price,
                                            onRowTapped: {
                                                selectedDish = item
                                            }
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
        .sheet(item: $selectedDish) { dish in
            DishDetailSheet(dish: dish) {
                let dummyCourt = Court(id: UUID().uuidString, name: dish.title)
                let slot = SelectedSlot(
                    date: Date(),
                    timeString: "Pre-order",
                    court: dummyCourt,
                    category: .recovery
                )
                withAnimation { cart.add(slot) }
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }
}

// MARK: - All Events Data Models

struct EventItem: Identifiable {
    let id = UUID()
    let day: String
    let month: String
    let title: String
    let time: String
    let location: String
    let isFeatured: Bool
}

struct EventSection: Identifiable {
    let id = UUID()
    let title: String
    let events: [EventItem]
}

let allEventsData: [EventSection] = [
    EventSection(title: "THIS WEEK", events: [
        EventItem(day: "20", month: "JUN", title: "Summer Solstice Mixer", time: "7:00 PM", location: "The Lounge", isFeatured: false),
        EventItem(day: "21", month: "JUN", title: "Pro Exhibition Match", time: "5:00 PM", location: "Center Court", isFeatured: false),
        EventItem(day: "22", month: "JUN", title: "Sunday Morning Recovery Flow", time: "8:00 AM", location: "Wellness Studio", isFeatured: false)
    ]),
    EventSection(title: "UPCOMING HIGHLIGHTS", events: [
        EventItem(day: "28", month: "JUN", title: "The Optimist Summer Gala", time: "8:00 PM", location: "Main Clubhouse", isFeatured: true),
        EventItem(day: "04", month: "JUL", title: "Courtside Wine Tasting", time: "6:30 PM", location: "The Lounge", isFeatured: false),
        EventItem(day: "12", month: "JUL", title: "Members' Mixed Doubles", time: "9:00 AM", location: "Courts 1-4", isFeatured: false),
        EventItem(day: "18", month: "JUL", title: "Friday Night DJ Sessions", time: "8:00 PM", location: "Courtside Bar", isFeatured: false)
    ]),
    EventSection(title: "CLINICS & WELLNESS", events: [
        EventItem(day: "25", month: "JUL", title: "Beginner's Masterclass", time: "10:00 AM", location: "Court 2", isFeatured: false),
        EventItem(day: "26", month: "JUL", title: "Breathwork & Cold Plunge", time: "7:00 AM", location: "Recovery Deck", isFeatured: false),
        EventItem(day: "02", month: "AUG", title: "Matcha Tasting & Networking", time: "11:00 AM", location: "The Lounge", isFeatured: false),
        EventItem(day: "09", month: "AUG", title: "Advanced Tactics Clinic", time: "4:00 PM", location: "Center Court", isFeatured: false)
    ])
]

// MARK: - Components

public struct EditorialEventRow: View {
    let event: EventItem
    
    public var body: some View {
        HStack(spacing: 24) {
            // Calendar Block
            VStack(spacing: -2) {
                Text(event.day)
                    .font(.custom("PlusJakartaSans-Bold", size: 28))
                    .foregroundColor(.Courtside.textPrimary)
                Text(event.month)
                    .font(.custom("PlusJakartaSans-SemiBold", size: 10))
                    .foregroundColor(.Courtside.primary)
                    .kerning(1)
            }
            .frame(width: 48)
            
            // Content
            VStack(alignment: .leading, spacing: 6) {
                Text(event.title)
                    .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                    .foregroundColor(.Courtside.textPrimary)
                    .lineLimit(2)
                
                HStack(spacing: 6) {
                    Text(event.time)
                    Text("•")
                        .foregroundColor(.Courtside.textSecondary.opacity(0.3))
                    Text(event.location)
                }
                .font(.custom("PlusJakartaSans-Regular", size: 13))
                .foregroundColor(.Courtside.textSecondary)
            }
            
            Spacer()
            
            // Action
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.Courtside.textSecondary.opacity(0.3))
        }
        .padding(.vertical, 8)
    }
}

public struct HeroEventCard: View {
    let event: EventItem
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Header
            HStack {
                Text("FEATURED EVENT")
                    .font(.custom("PlusJakartaSans-SemiBold", size: 10))
                    .foregroundColor(Color.white.opacity(0.6))
                    .kerning(2)
                
                Spacer()
                
                HStack(spacing: 4) {
                    Text(event.day)
                    Text(event.month)
                }
                .font(.custom("PlusJakartaSans-Bold", size: 12))
                .foregroundColor(.white)
            }
            
            Spacer()
            
            // Content
            VStack(alignment: .leading, spacing: 16) {
                Text(event.title)
                    .font(.custom("PlusJakartaSans-Regular", size: 32))
                    .foregroundColor(.white)
                    .lineLimit(2)
                
                HStack(spacing: 8) {
                    Text(event.time)
                    Text("•")
                        .foregroundColor(Color.white.opacity(0.3))
                    Text(event.location)
                }
                .font(.custom("PlusJakartaSans-Regular", size: 14))
                .foregroundColor(Color.white.opacity(0.8))
            }
            
            // RSVP
            HStack {
                Spacer()
                Text("RSVP")
                    .font(.custom("PlusJakartaSans-Bold", size: 12))
                    .foregroundColor(.Courtside.textPrimary)
                    .kerning(1)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .clipShape(Capsule())
            }
            .padding(.top, 16)
        }
        .padding(32)
        .frame(height: 380)
        .background(Color.Courtside.primary)
        .cornerRadius(24)
        .shadow(color: Color.Courtside.primary.opacity(0.2), radius: 30, x: 0, y: 15)
    }
}

// MARK: - All Events Implementation

public struct AllEventsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    public var body: some View {
        ZStack {
            Color.Courtside.background.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    // Header
                    HStack {
                        Text("Experiences")
                            .font(.Courtside.heroDisplay)
                            .foregroundColor(.Courtside.textPrimary)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 40)
                    .padding(.bottom, 48)
                    
                    // Sections
                    VStack(spacing: 64) {
                        ForEach(allEventsData) { section in
                            VStack(alignment: .leading, spacing: 32) {
                                
                                // Section Header
                                Text(section.title)
                                    .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                                    .foregroundColor(.Courtside.textSecondary)
                                    .kerning(2)
                                    .padding(.horizontal, 24)
                                
                                // Section Items
                                VStack(spacing: 16) {
                                    ForEach(section.events) { event in
                                        if event.isFeatured {
                                            HeroEventCard(event: event)
                                                .padding(.horizontal, 24)
                                                .padding(.bottom, 16)
                                        } else {
                                            EditorialEventRow(event: event)
                                                .padding(.horizontal, 24)
                                            
                                            // Subtle divider between standard rows
                                            if event.id != section.events.last?.id {
                                                Rectangle()
                                                    .fill(Color.Courtside.textSecondary.opacity(0.08))
                                                    .frame(height: 1)
                                                    .padding(.leading, 96) // Align with text
                                                    .padding(.trailing, 24)
                                                    .padding(.vertical, 8)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom, 120)
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

// MARK: - Dish Detail Sheet

public struct DishDetailSheet: View {
    let dish: MenuItem
    let onAdd: () -> Void
    @Environment(\.presentationMode) var presentationMode
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            Color.Courtside.background.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    // Hero Image Placeholder
                    Rectangle()
                        .fill(Color.Courtside.textSecondary.opacity(0.08))
                        .frame(height: 320)
                        .overlay(
                            VStack(spacing: 12) {
                                Image(systemName: "camera.macro")
                                    .font(.system(size: 32))
                                    .foregroundColor(.Courtside.textSecondary.opacity(0.4))
                                Text("Image Placeholder")
                                    .font(.custom("PlusJakartaSans-SemiBold", size: 12))
                                    .foregroundColor(.Courtside.textSecondary.opacity(0.6))
                                    .kerning(1)
                            }
                        )
                    
                    VStack(alignment: .leading, spacing: 40) {
                        
                        // Header
                        VStack(alignment: .leading, spacing: 12) {
                            Text(dish.title)
                                .font(.Courtside.heroDisplay)
                                .foregroundColor(.Courtside.textPrimary)
                            
                            Text(dish.price)
                                .font(.custom("PlusJakartaSans-SemiBold", size: 18))
                                .foregroundColor(.Courtside.primary)
                            
                            if let desc = dish.description {
                                Text(desc)
                                    .font(.custom("PlusJakartaSans-Regular", size: 15))
                                    .foregroundColor(.Courtside.textSecondary)
                                    .lineSpacing(6)
                                    .padding(.top, 4)
                            }
                        }
                        
                        // Macros
                        VStack(alignment: .leading, spacing: 20) {
                            Text("NUTRITIONAL PROFILE")
                                .font(.custom("PlusJakartaSans-SemiBold", size: 11))
                                .foregroundColor(.Courtside.textSecondary)
                                .kerning(2)
                            
                            HStack(spacing: 12) {
                                MacroBadge(label: "CALORIES", value: dish.macros.calories)
                                MacroBadge(label: "PROTEIN", value: dish.macros.protein)
                                MacroBadge(label: "CARBS", value: dish.macros.carbs)
                                MacroBadge(label: "FATS", value: dish.macros.fats)
                            }
                        }
                        
                        // Ingredients
                        VStack(alignment: .leading, spacing: 20) {
                            Text("INGREDIENTS")
                                .font(.custom("PlusJakartaSans-SemiBold", size: 11))
                                .foregroundColor(.Courtside.textSecondary)
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
                                            .foregroundColor(.Courtside.textPrimary)
                                    }
                                }
                            }
                        }
                    }
                    .padding(32)
                    .padding(.bottom, 140) // Space for sticky button
                }
            }
            
            // Sticky Add Button
            VStack {
                Button(action: {
                    onAdd()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("ADD TO ORDER — \(dish.price)")
                        .font(.custom("PlusJakartaSans-Bold", size: 14))
                        .foregroundColor(.white)
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
                .foregroundColor(.Courtside.textPrimary)
            Text(label)
                .font(.custom("PlusJakartaSans-Regular", size: 9))
                .foregroundColor(.Courtside.textSecondary)
                .kerning(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color.Courtside.textSecondary.opacity(0.04))
        .cornerRadius(16)
    }
}
