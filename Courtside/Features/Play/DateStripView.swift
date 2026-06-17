import SwiftUI

public struct DateStripView: View {
    @Binding var selectedDate: Date
    @State private var showCalendar = false
    @State private var stripStartDate: Date = Calendar.current.startOfDay(for: Date())
    
    public init(selectedDate: Binding<Date>) {
        self._selectedDate = selectedDate
    }
    
    private var dates: [Date] {
        var datesArray: [Date] = []
        let calendar = Calendar.current
        for i in 0..<14 {
            if let date = calendar.date(byAdding: .day, value: i, to: stripStartDate) {
                datesArray.append(date)
            }
        }
        return datesArray
    }
    
    private var currentMonthString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: selectedDate).uppercased()
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(currentMonthString)
                .font(.custom("PlusJakartaSans-Regular", size: 12))
                .kerning(2)
                .foregroundColor(.Courtside.textSecondary)
                .padding(.horizontal, 24)
            
            ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 32) {
                // Calendar Picker Button
                Button(action: {
                    showCalendar = true
                }) {
                    Image(systemName: "calendar")
                        .font(.system(size: 28, weight: .light))
                        .foregroundColor(.Courtside.textPrimary)
                        .padding(.vertical, 8) // Visually aligns with the date stack
                }
                
                ForEach(dates, id: \.self) { date in
                    Button(action: {
                        withAnimation {
                            selectedDate = date
                        }
                    }) {
                        VStack(spacing: 8) {
                            Text(dayString(for: date))
                                .font(.custom("PlusJakartaSans-Regular", size: 10))
                                .kerning(1.5)
                                .foregroundColor(.Courtside.textSecondary)
                            
                            Text(dateString(for: date))
                                .font(.custom("PlusJakartaSans-Regular", size: 20))
                                .foregroundColor(isSelected(date) ? .Courtside.textPrimary : .Courtside.textSecondary)
                            
                            // Selection Indicator
                            Circle()
                                .fill(isSelected(date) ? Color.Courtside.primary : Color.clear)
                                .frame(width: 4, height: 4)
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
        }
        .sheet(isPresented: $showCalendar) {
            NavigationView {
                VStack {
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .padding()
                        .accentColor(.Courtside.primary)
                    Spacer()
                }
                .navigationTitle("Select Date")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            showCalendar = false
                        }
                        .foregroundColor(.Courtside.primary)
                    }
                }
            }
            .presentationDetents([.medium, .large])
        }
        .onChange(of: selectedDate) {
            let calendar = Calendar.current
            let start = calendar.startOfDay(for: selectedDate)
            
            // If the picked date is not in our current visible strip, shift the strip to start at that date
            let isDateInStrip = dates.contains { calendar.isDate($0, inSameDayAs: start) }
            if !isDateInStrip {
                stripStartDate = start
            }
        }
        }
    }
    
    private func isSelected(_ date: Date) -> Bool {
        Calendar.current.isDate(date, inSameDayAs: selectedDate)
    }
    
    private func dayString(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date).uppercased()
    }
    
    private func dateString(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
}
