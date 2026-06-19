import SwiftUI

public struct PlayView: View {
    @State private var viewModel = PlayViewModel()

    public init() {}

    public var body: some View {
        ZStack {
            Color.Courtside.background.ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("Reserve")
                        .font(.Courtside.heroDisplay)
                        .foregroundStyle(Color.Courtside.primary)

                    Spacer()

                    LegendItem(title: "Peak", icon: "flame.fill", color: .Courtside.primary)
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)

                ScrollView {
                    LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                        Section(header:
                            VStack(spacing: 32) {
                                DateStripView(selectedDate: $viewModel.selectedDate)
                                CategorySelectorView(selectedCategory: $viewModel.selectedCategory)
                            }
                            .padding(.vertical, 16)
                            .background(Color.Courtside.background)
                        ) {
                            TimeSlotListView(
                                timeSlots: $viewModel.timeSlots,
                                selectedDate: viewModel.selectedDate,
                                selectedCategory: viewModel.selectedCategory
                            ) {
                                viewModel.showToast("This court is already booked.")
                            }
                            .padding(.bottom, 120)
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }

            if let message = viewModel.toastMessage {
                VStack {
                    Spacer()
                    Text(message)
                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.black.opacity(0.85))
                        .clipShape(.capsule)
                        .padding(.bottom, 40)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(1)
            }
        }
        .overlay(alignment: .bottom) {
            LinearGradient(colors: [.clear, Color.Courtside.background], startPoint: .top, endPoint: .bottom)
                .frame(height: 120)
                .allowsHitTesting(false)
                .ignoresSafeArea()
        }
        .task {
            viewModel.generateSlots()
        }
        .onChange(of: viewModel.selectedDate) {
            viewModel.generateSlots()
        }
        .onChange(of: viewModel.selectedCategory) {
            viewModel.generateSlots()
        }
    }
}

// MARK: - LegendItem

public struct LegendItem: View {
    let title: String
    let icon: String
    let color: Color

    public var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 8))
                .foregroundStyle(color)
            Text(title)
                .font(.custom("PlusJakartaSans-Regular", size: 10))
                .foregroundStyle(Color.Courtside.textSecondary)
                .kerning(1.5)
        }
    }
}
