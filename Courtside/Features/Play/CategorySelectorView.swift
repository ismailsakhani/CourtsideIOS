import SwiftUI

public struct CategorySelectorView: View {
    @Binding var selectedCategory: GameCategory
    
    public init(selectedCategory: Binding<GameCategory>) {
        self._selectedCategory = selectedCategory
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(GameCategory.allCases, id: \.self) { category in
                Button(action: {
                    withAnimation {
                        selectedCategory = category
                    }
                }) {
                    VStack(spacing: 8) {
                        Text(category.rawValue)
                            .font(.custom("PlusJakartaSans-Regular", size: 12))
                            .kerning(1.5)
                            .foregroundColor(selectedCategory == category ? .Courtside.textPrimary : .Courtside.textSecondary)
                        
                        // Selection Indicator
                        Circle()
                            .fill(selectedCategory == category ? Color.Courtside.primary : Color.clear)
                            .frame(width: 4, height: 4)
                    }
                }
                
                if category != GameCategory.allCases.last {
                    Spacer(minLength: 0)
                }
            }
        }
        .padding(.horizontal, 24)
    }
}
