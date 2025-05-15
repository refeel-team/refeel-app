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

    let categories = Category.allCases
    @State private var selectedCategory: Category? = nil
    @State private var selectedDate: Date? = nil

    @Query var retrospects: [Retrospect]

    var body: some View {
        NavigationStack {
            VStack {
                HStack { // 타이틀 제목, 년도, 월 선택!!
                    Text("통계 화면 제목")
                        .font(.title)
                        .bold()

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

                ScrollView(.horizontal) {
                    HStack {
                        Button {
                            selectedCategory = nil
                        } label: {
                            Text("전체 보기")
                                .foregroundStyle(.black)
                                .fontWeight(.semibold)
                                .padding()
                                .background {
                                    Capsule()
                                        .fill(selectedCategory == nil ? .green : .yellow)
                                        .frame(width: 70, height: 30)

                                    Capsule()
                                        .stroke(lineWidth: 1)
                                        .fill(.black)
                                        .frame(width: 70, height: 30)
                                }
                                .padding(.horizontal, 8)

                        }

                        ForEach(categories, id: \.self) { category in
                            Button {
                                selectedCategory = category
                            } label: {
                                Text(category.rawValue)
                                    .foregroundStyle(.black)
                                    .fontWeight(.semibold)
                                    .padding()
                                    .background {
                                        Capsule()
                                            .fill(selectedCategory == category ? .green : .yellow)
                                            .frame(width: 70, height: 30)

                                        Capsule()
                                            .stroke(lineWidth: 1)
                                            .fill(.black)
                                            .frame(width: 70, height: 30)
                                    }
                                    .padding(.horizontal, 8)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)

                Spacer()

                ScrollView { // 통계 자료 목록
                    VStack(alignment: .trailing) {
                        // 카테고리에 맞는 데이터 개수 표시
                        Text("\(selectedCategory?.rawValue ?? "전체"): \(filteredRetrospects().count)개")
                            .bold()
                            .padding()

                        ForEach(filteredRetrospects(), id: \.self) { retrospect in
                            HStack {
                                Text(retrospect.content ?? "")
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Text(formattedDate(retrospect.date))
                                    .foregroundStyle(.gray)
                            }
                            .padding(.vertical, 4)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedDate = retrospect.date // 날짜만 선택해서 이동
                            }
                        }
                    }
                    Spacer()
                }
                .background(Color(.systemBackground))
            }
            .padding()
            .navigationDestination(item: $selectedDate) { date in
                RetrospectDetailView(selectedDate: date)
            }
        }
    }

    private func filteredRetrospects() -> [Retrospect] {
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
            formattedDateOnly(retrospect.date)
        }

        let earliestPerDay = grouped.values.compactMap { group in
            group.sorted { $0.date < $1.date }.first
        }
        // 최신 날짜가 위로 오도록 정렬
        return earliestPerDay.sorted { $0.date > $1.date }
    }

    private func formattedDateOnly(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // 날짜까지만 사용
        return formatter.string(from: date)
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter.string(from: date)
    }
}

#Preview {
    StatisticsView()
}
