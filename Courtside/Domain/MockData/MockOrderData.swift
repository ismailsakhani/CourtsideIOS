import Foundation

public struct OrderHistoryItem: Identifiable {
    public let id = UUID()
    let orderNumber: String
    let dateStr: String
    let itemsStr: String
    let totalAmount: String
}

let mockOrders: [OrderHistoryItem] = [
    OrderHistoryItem(orderNumber: "#ORD-9021", dateStr: "24 Oct, 2024", itemsStr: "Signature Latte x1, Avocado Toast x1", totalAmount: "₹850"),
    OrderHistoryItem(orderNumber: "#ORD-8942", dateStr: "18 Oct, 2024", itemsStr: "Matcha Latte x2, Croissant x1", totalAmount: "₹1,100"),
    OrderHistoryItem(orderNumber: "#ORD-8110", dateStr: "02 Oct, 2024", itemsStr: "Iced Americano x1, Protein Bowl x1", totalAmount: "₹950"),
    OrderHistoryItem(orderNumber: "#ORD-7650", dateStr: "15 Sep, 2024", itemsStr: "Flat White x1", totalAmount: "₹350")
]
