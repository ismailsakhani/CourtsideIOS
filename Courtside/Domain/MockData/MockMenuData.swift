import Foundation

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

var loungeFeatureItems: [MenuItem] {
    var items: [MenuItem] = []
    // RECOVERY SHAKES [5], SPECIALTY COFFEE [2], HEALTHY BOWLS [0]
    if fullMenuData.count > 5, fullMenuData[5].items.count > 1 { items.append(fullMenuData[5].items[1]) }
    if fullMenuData.count > 2, fullMenuData[2].items.count > 2 { items.append(fullMenuData[2].items[2]) }
    if fullMenuData.count > 0, fullMenuData[0].items.count > 5 { items.append(fullMenuData[0].items[5]) }
    return items
}
