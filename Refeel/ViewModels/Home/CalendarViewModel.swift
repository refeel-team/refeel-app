//
//  CalendarViewModel.swift
//  Refeel
//
//  Created by hyunMac on 5/18/25.
//

import Foundation

@MainActor
final class CalendarViewModel: ObservableObject {
    @Published var currentDate: Date = Date()

    var monthTitle: String {
        return DateFormatter.koreanYearMonth.string(from: currentDate)
    }

    func moveMonth(by value: Int) {
        guard let new = Calendar.current.date(byAdding: .month, value: value, to: currentDate) else { return }
        currentDate = new
    }

    func generateCalendar() -> [Date] {
        var calendar = Calendar.current
        calendar.firstWeekday = 1

        guard let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate)) else {
            return []
        }

        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        let frontPadding = firstWeekday - calendar.firstWeekday
        let startDate = calendar.date(byAdding: .day, value: -frontPadding, to: firstDayOfMonth) ?? firstDayOfMonth

        var days: [Date] = []
        for i in 0..<42 {
            if let date = calendar.date(byAdding: .day, value: i, to: startDate) {
                days.append(date)
            }
        }
        return days
    }

    func isWritten(date: Date, retrospects: [Retrospect]) -> Bool {
        let dateforSearch = Calendar.current.startOfDay(for: date)
        return retrospects.contains(where: {
            Calendar.current.isDate($0.date, inSameDayAs: dateforSearch)
        })
    }
}

extension DateFormatter {
    static let koreanYearMonth: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "yyyy년 MM월"
        return df
    }()
}
