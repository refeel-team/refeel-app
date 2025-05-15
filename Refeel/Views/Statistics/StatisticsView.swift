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
    @State private var isYearSheetPresented = false
    @State private var isMonthSheetPresented = false

    @Query var retrospects: [Retrospect]

    var sortedCategoriesByCount: [Category] {
        let counts = Dictionary(grouping: retrospects, by: \.category)
            .mapValues { $0.count }

        return categories.sorted {
            (counts[$0] ?? 0) > (counts[$1] ?? 0)
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                HStack { // 타이틀 제목, 년도, 월 선택!!
                    Text("하루 기록들")
                        .font(.title)
                        .bold()

                    Spacer()

                    Button {
                        isYearSheetPresented.toggle()
                    } label: {
                        HStack(spacing: 6) {
                            Text(String(format: "%d년", selectedYear))
                                .fontWeight(.medium)
                                .foregroundStyle(Color.primaryColor)

                            Image(systemName: "chevron.down")
                                .imageScale(.small)
                                .foregroundStyle(Color.primaryColor)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.primaryColor, lineWidth: 1)
                        }
                    }




                    .sheet(isPresented: $isYearSheetPresented) {
                        VStack {
                            // 연도 선택 Picker
                            Picker("연도", selection: $selectedYear) {
                                ForEach(2015...2035, id: \.self) { year in
                                    Text(String(format: "%d년", year)) // 연도 표시
                                }
                            }
                            .pickerStyle(WheelPickerStyle()) // 회전형 Picker
                            .frame(height: 150)

                            Button("확인") {
                                isYearSheetPresented = false // 바텀 시트 닫기
                            }
                            .padding()
                            .foregroundColor(.blue)
                        }
                        .padding()
                        .presentationDetents([.fraction(0.4)])
                    }

                    Button {
                        isMonthSheetPresented.toggle()
                    } label: {
                        HStack(spacing: 6) {
                            Text("\(selectedMonth)월")
                                .fontWeight(.medium)
                                .foregroundStyle(Color.primaryColor)

                            Image(systemName: "chevron.down")
                                .imageScale(.small)
                                .foregroundStyle(Color.primaryColor)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.primaryColor, lineWidth: 1)
                        }
                    }



                    .sheet(isPresented: $isMonthSheetPresented) {
                        VStack {
                            // 연도 선택 Picker
                            Picker("월", selection: $selectedMonth) {
                                ForEach(1...12, id: \.self) { month in
                                    Text("\(month)월")
                                }
                            }
                            .pickerStyle(WheelPickerStyle()) // 회전형 Picker
                            .frame(height: 150)

                            Button("확인") {
                                isMonthSheetPresented = false // 바텀 시트 닫기
                            }
                            .padding()
                            .foregroundColor(.blue)
                        }
                        .padding()
                        .presentationDetents([.fraction(0.4)])
                    }

                }
                .padding()

                ScrollView(.horizontal) {
                    HStack(spacing: 6) {
                        Button {
                            selectedCategory = nil
                        } label: {
                            TagView(tag: StringTag(tagText: "전체 보기"), color: selectedCategory == nil ? Color.primaryColor : .gray)
                                .padding(.horizontal, 8)
                        }

                        ForEach(sortedCategoriesByCount, id: \.self) { category in
                            Button {
                                selectedCategory = category
                            } label: {
                                TagView(tag: category, color: selectedCategory == category ? Color.primaryColor : .gray)
                            }
                        }
                        .padding(.trailing, 13)
                    }
                }
                .scrollIndicators(.hidden)

                Spacer()

                List {
                    // 카테고리 개수 표시 - Section header에 넣기
                    Section(header:
                                Text("\(selectedCategory?.rawValue ?? "전체"): \(filteredRetrospects().count)개")
                        .font(.headline)
                        .padding(.vertical, 4)
                    ) {
                        ForEach(filteredRetrospects(), id: \.self) { retrospect in
                            HStack {
                                Text(retrospect.content ?? "")
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Text(formattedDate(retrospect.date))
                                    .foregroundStyle(.gray)
                            }
                            .padding(.vertical, 4)
                            .contentShape(Rectangle())
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                .background(.background)
            }
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
            formattedDate(retrospect.date)
        }

        let earliestPerDay = grouped.values.compactMap { group in
            group.sorted { $0.date < $1.date }.first
        }
        // 최신 날짜가 위로 오도록 정렬
        return earliestPerDay.sorted { $0.date > $1.date }
    }
}

#Preview {
    StatisticsView()
}
