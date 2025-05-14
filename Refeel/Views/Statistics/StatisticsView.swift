//
//  StatisticsView.swift
//  Refeel
//
//  Created by hyunMac on 5/12/25.
//

import SwiftUI
import SwiftData

struct StatisticsView: View {
    @State private var selectedYear = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth = Calendar.current.component(.month, from: Date())

    @State private var selectedIndex: Int? = nil
    let categories = Category.allCases
    @State private var selectedCategory: Category? = nil

    @Query var retrospects: [Retrospect]


    var body: some View {
        VStack {
            HStack { // 타이틀 제목, 년도, 월 선택
                Text("통계 화면 제목")

                Spacer()

                Picker("연도", selection: $selectedYear) {
                    ForEach(2025...2027, id: \.self) { year in
                        Text(String(format: "%d년", year))
                    }
                }
                .buttonStyle(.bordered)

                Picker("월", selection: $selectedMonth) {
                    ForEach(1...12, id: \.self) { month in
                        Text("\(month)월")
                    }
                }
                .buttonStyle(.bordered)
            }

            ScrollView(.horizontal) { // 가로 스크롤 카테고리
                HStack {
                    ForEach(Array(categories.enumerated()), id: \.offset) { index, category in
                        Button {
                            selectedCategory = category
                        } label: {
                            Text(category.rawValue)
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .fill(selectedCategory == category ? .green : .green.opacity(0.6))
                                )
                        }
                    }

                }
            }
            .scrollIndicators(.hidden)

            Spacer()

            if let category = selectedCategory {
                let filtered = filteredRetrospects()
                ScrollView {
                    VStack(alignment: .trailing) {
                        Text("\(category.rawValue): 10개")
                            .bold()
                            .padding()

                        HStack {
                            VStack(alignment: .leading) {
                                ForEach(filtered, id: \.self) { retrospect in
                                    Text(retrospect.content ?? "데이터가 비어있음")
                                }
                            }

                            Spacer()

                            VStack {
                                ForEach(filtered, id: \.self) { retrospect in
                                    Text(formattedDate(retrospect.date))
                                }
                            }
                        }
                    }
                }
                Spacer()
            } else {
                Label("카테고리를 선택해주세요.", systemImage: "bubble.right.circle.fill")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 350)
            }
        }
        .padding()
    }
    private func filteredRetrospects() -> [Retrospect] {
        guard let category = selectedCategory else { return [] }

        return retrospects.filter { retrospect in
            let components = Calendar.current.dateComponents([.year, .month], from: retrospect.date)
            return retrospect.category == category &&
            components.year == selectedYear &&
            components.month == selectedMonth
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        return formatter.string(from: date)
    }

}

#Preview {
    StatisticsView()
}
