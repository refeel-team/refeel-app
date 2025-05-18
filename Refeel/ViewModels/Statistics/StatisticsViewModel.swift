//
//  StatisticsViewModel.swift
//  Refeel
//
//  Created by hyunMac on 5/18/25.
//

import Foundation

@MainActor

final class StatisticsViewModel: ObservableObject {
    @Published var selectedYear = Calendar.current.component(.year, from: Date())
    @Published var selectedMonth = Calendar.current.component(.month, from: Date())
    @Published var selectedCategory: Category? = nil
    @Published var selectedDate: Date? = nil
    @Published var isYearSheetPresented = false
    @Published var isMonthSheetPresented = false

    private let categories = Category.allCases

    func sortedCategoriesByCount(retrospects: [Retrospect]) -> [Category] {
        let counts = Dictionary(grouping: retrospects, by: \.category)
            .mapValues { $0.count }

        return categories.sorted {
            (counts[$0] ?? 0) > (counts[$1] ?? 0)
        }
    }

    func filteredRetrospects(retrospects: [Retrospect]) -> [Retrospect] {
        let filtered = retrospects.filter { retrospect in
            let components = Calendar.current.dateComponents([.year, .month], from: retrospect.date)
            let isYearAndMonthMatching = components.year == selectedYear && components.month == selectedMonth

            if let category = selectedCategory {
                return retrospect.category == category && isYearAndMonthMatching
            } else {
                return isYearAndMonthMatching
            }
        }
        let grouped = Dictionary(grouping: filtered) { retrospect in
            formattedDate(retrospect.date)
        }

        let earliestPerDay = grouped.values.compactMap { group in
            group.sorted { $0.date < $1.date }.first
        }
        // 최신 날짜가 위로 오도록 정렬
        return earliestPerDay.sorted { $0.date > $1.date }
    }
}
