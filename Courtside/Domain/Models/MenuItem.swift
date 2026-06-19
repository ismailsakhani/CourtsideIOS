import Foundation

public struct MenuMacros: Equatable {
    public let calories: String
    public let protein: String
    public let carbs: String
    public let fats: String
}

public struct MenuItem: Identifiable, Equatable {
    public let id = UUID()
    public let title: String
    public let description: String?
    public let price: String
    public let ingredients: [String]
    public let macros: MenuMacros
}

public struct MenuSection: Identifiable {
    public let id = UUID()
    public let title: String
    public let subtitle: String?
    public let items: [MenuItem]
    public let isSpecial: Bool
}
