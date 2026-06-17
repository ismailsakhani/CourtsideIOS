import SwiftUI

public struct PlayView: View {
    @State private var selectedDate: Date = Date()
    @State private var selectedCategory: GameCategory = .padel
    @State private var timeSlots: [TimeSlot] = []
    @State private var toastMessage: String? = nil
    
    public init() {}
    
    public var body: some View {
        ZStack {
            Color.Courtside.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("Reserve.")
                        .font(.Courtside.heroDisplay)
                        .foregroundColor(.Courtside.textPrimary)
                    
                    Spacer()
                    
                    // Legend
                    HStack(spacing: 12) {
                        LegendItem(title: "Peak", icon: "flame.fill", color: .Courtside.primary)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)
                .padding(.bottom, 32)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 48, pinnedViews: [.sectionHeaders]) {
                        Section(header: 
                            VStack(spacing: 32) {
                                DateStripView(selectedDate: $selectedDate)
                                CategorySelectorView(selectedCategory: $selectedCategory)
                            }
                            .padding(.vertical, 16)
                            .background(Color.Courtside.background)
                        ) {
                            TimeSlotListView(timeSlots: $timeSlots, selectedDate: selectedDate, selectedCategory: selectedCategory) {
                                withAnimation {
                                    toastMessage = "This court is already booked."
                                }
                            }
                            .padding(.bottom, 120)
                        }
                    }
                }
            }
            
            // App-level Custom Toast
            if let message = toastMessage {
                VStack {
                    Spacer()
                    Text(message)
                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.black.opacity(0.85))
                        .cornerRadius(24)
                        .padding(.bottom, 40)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(1)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation { toastMessage = nil }
                    }
                }
            }
        }
        .onAppear {
            generateSlots()
        }
        .onChange(of: selectedDate) {
            generateSlots()
        }
        .onChange(of: selectedCategory) {
            generateSlots()
        }
    }
    
    private func generateSlots() {
        var newSlots: [TimeSlot] = []
        
        let startHour = (selectedCategory == .studio || selectedCategory == .recovery) ? 6 : 0
        let endHour = 23
        
        for hour in startHour...endHour {
            for minute in [0, 30] {
                // Skip 11:30 PM if not requested, but prompt says "to 11:30pm" so include it.
                let courts = courtsForCategory(selectedCategory)
                let isPeak = isPeakTime(date: selectedDate, hour: hour)
                
                // Formulate time string
                let ampm = hour >= 12 ? "PM" : "AM"
                let displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour)
                let startTimeString = String(format: "%02d:%02d %@", displayHour, minute, ampm)
                
                var endHour = hour
                var endMinute = minute + 30
                if endMinute == 60 {
                    endMinute = 0
                    endHour += 1
                }
                let endAmPm = (endHour % 24) >= 12 ? "PM" : "AM"
                let endDisplayHour = (endHour % 24) > 12 ? (endHour % 24) - 12 : ((endHour % 24) == 0 ? 12 : (endHour % 24))
                let endTimeString = String(format: "%02d:%02d %@", endDisplayHour, endMinute, endAmPm)
                
                let timeString = "\(startTimeString) - \(endTimeString)"
                
                // Mock Bookings (randomly book some slots for realistic feel)
                var courtStatuses: [CourtStatus] = []
                for court in courts {
                    // Randomly book ~30% of slots. In a real app this comes from API.
                    let isBooked = Int.random(in: 1...10) > 7
                    courtStatuses.append(CourtStatus(court: court, isBooked: isBooked, isSelected: false))
                }
                
                newSlots.append(TimeSlot(
                    timeString: timeString,
                    hour: hour,
                    minute: minute,
                    courts: courtStatuses,
                    isPeak: isPeak
                ))
            }
        }
        
        self.timeSlots = newSlots
    }
    
    private func courtsForCategory(_ category: GameCategory) -> [Court] {
        switch category {
        case .padel: return [.isprava, .court2, .court3]
        case .pickleball: return [.pickleball1]
        case .studio: return [.studio]
        case .recovery: return [.studio]
        }
    }
    
    private func isPeakTime(date: Date, hour: Int) -> Bool {
        let calendar = Calendar.current
        let isWeekend = calendar.isDateInWeekend(date)
        
        if isWeekend {
            // 5 PM (17) to 11 PM (23)
            return hour >= 17 && hour <= 23
        } else {
            // 5 PM (17) to 8 PM (20)
            return hour >= 17 && hour <= 20
        }
    }
}

public struct LegendItem: View {
    let title: String
    let icon: String
    let color: Color
    
    public var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 8))
                .foregroundColor(color)
            Text(title)
                .font(.custom("PlusJakartaSans-Regular", size: 10))
                .foregroundColor(.Courtside.textSecondary)
                .kerning(1.5)
        }
    }
}
