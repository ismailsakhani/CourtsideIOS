import SwiftUI

public struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.Courtside.button)
                .foregroundColor(.Courtside.background)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(Color.Courtside.primary)
                .cornerRadius(12)
        }
    }
}
