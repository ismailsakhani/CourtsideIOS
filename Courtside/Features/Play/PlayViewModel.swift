import Observation
import Foundation

@Observable
@MainActor
final class PlayViewModel {
    var timeSlots: [TimeSlot] = []
    var selectedDate: Date = Calendar.current.startOfDay(for: .now)
    var selectedCategory: GameCategory = .padel
    var toastMessage: String? = nil

    func generateSlots() {
        let startHour = startHourForCategory(selectedCategory)
        let endHour = 23
        var newSlots: [TimeSlot] = []

        for hour in startHour...endHour {
            for minute in [0, 30] {
                let courts = courtsForCategory(selectedCategory)
                let isPeak = isPeakTime(date: selectedDate, hour: hour)
                let timeString = formatTimeRange(hour: hour, minute: minute)

                let courtStatuses: [CourtStatus] = courts.map { court in
                    var hasher = Hasher()
                    hasher.combine(Int(selectedDate.timeIntervalSince1970))
                    hasher.combine(court.id)
                    hasher.combine(hour)
                    hasher.combine(minute)
                    let seed = abs(hasher.finalize())
                    let isBooked = seed % 10 > 7
                    return CourtStatus(court: court, isBooked: isBooked, isSelected: false)
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
        timeSlots = newSlots
    }

    func showToast(_ message: String) {
        toastMessage = message
        Task {
            try? await Task.sleep(for: .seconds(2.5))
            toastMessage = nil
        }
    }

    private func courtsForCategory(_ category: GameCategory) -> [Court] {
        switch category {
        case .padel:       return [.court1, .court2, .isprava]
        case .pickleball:  return [.pickleball1]
        case .studio:      return [.barre57, .reformer, .yoga]
        case .recovery:    return [.room1, .room2]
        }
    }

    private func startHourForCategory(_ category: GameCategory) -> Int {
        switch category {
        case .padel:       return 0  // 12:00 AM – 11:30 PM
        case .pickleball:  return 0  // 12:00 AM – 11:30 PM
        case .studio:      return 6  // 6:00 AM  – 11:30 PM
        case .recovery:    return 6  // 6:00 AM  – 11:30 PM
        }
    }

    private func isPeakTime(date: Date, hour: Int) -> Bool {
        let isWeekend = Calendar.current.isDateInWeekend(date)
        return isWeekend ? (hour >= 17 && hour <= 23) : (hour >= 17 && hour <= 20)
    }

    private func formatTimeRange(hour: Int, minute: Int) -> String {
        let startAmPm = hour >= 12 ? "PM" : "AM"
        let startDisplay = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour)

        var endHour = hour
        var endMinute = minute + 30
        if endMinute == 60 { endMinute = 0; endHour += 1 }

        let endAmPm = (endHour % 24) >= 12 ? "PM" : "AM"
        let endDisplay = (endHour % 24) > 12 ? (endHour % 24) - 12 : ((endHour % 24) == 0 ? 12 : (endHour % 24))

        return String(format: "%d:%02d %@ – %d:%02d %@",
                      startDisplay, minute, startAmPm,
                      endDisplay, endMinute, endAmPm)
    }
}
