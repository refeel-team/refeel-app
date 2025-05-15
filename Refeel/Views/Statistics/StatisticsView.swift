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

    @Environment(\.colorScheme) var colorScheme
    
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
                        .bold()
                        .font(.cafe24SsurroundAir(size: 24))

                    Spacer()

                    Button {
                        isYearSheetPresented.toggle()
                    } label: {
                        HStack(spacing: 6) {
                            Text(String(format: "%d년", selectedYear))
                                .font(.cafe24SsurroundAir(size: 16))
                                .foregroundStyle(Color.primaryColor)

                            Image(systemName: "chevron.down")
                                .imageScale(.small)
                                .foregroundStyle(colorScheme == .dark ? Color.powderCloudBlue : Color.twilightNavy)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    colorScheme == .dark ? Color.powderCloudBlue : Color.twilightNavy,
                                    lineWidth: 1)
                        }
                    }

                    .sheet(isPresented: $isYearSheetPresented) {
                        VStack {
                            // 연도 선택 Picker
                            Picker("연도", selection: $selectedYear) {
                                ForEach(2015...2035, id: \.self) { year in
                                    Text(String(format: "%d년", year)) // 연도 표시
                                        .font(.cafe24SsurroundAir(size: 16))
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(height: 150)

                            Button{
                                isYearSheetPresented = false
                            } label : {
                                Text("확인")
                                    .font(.cafe24SsurroundAir(size: 16))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 40)
                                    .background(Color.primaryColor)
                                    .cornerRadius(12)
                                    .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                            }
                        }
                        .padding()
                        .presentationDetents([.fraction(0.3)])
                    }

                    Button {
                        isMonthSheetPresented.toggle()
                    } label: {
                        HStack(spacing: 6) {
                            Text("\(selectedMonth)월")
                                .foregroundStyle(Color.primaryColor)
                                .font(.cafe24SsurroundAir(size: 16))

                            Image(systemName: "chevron.down")
                                .imageScale(.small)
                                .foregroundStyle(colorScheme == .dark ? Color.powderCloudBlue : Color.twilightNavy)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    colorScheme == .dark ? Color.powderCloudBlue : Color.twilightNavy,
                                    lineWidth: 1)
                        }
                    }
<<<<<<< HEAD
=======

>>>>>>> 8299723bd4f4c3df6c251cc58fd89944764de96b
                    .sheet(isPresented: $isMonthSheetPresented) {
                        VStack {
                            // 연도 선택 Picker
                            Picker("월", selection: $selectedMonth) {
                                ForEach(1...12, id: \.self) { month in
                                    Text("\(month)월")
                                        .font(.cafe24SsurroundAir(size: 16))
                                }
                            }
                            .pickerStyle(WheelPickerStyle()) // 회전형 Picker
                            .frame(height: 150)

                            Button{
                                isMonthSheetPresented = false
                            } label : {
                                Text("확인")
                                    .font(.cafe24SsurroundAir(size: 16))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 40)
                                    .background(Color.primaryColor)
                                    .cornerRadius(12)
                                    .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                            }
                        }
                        .padding()
                        .presentationDetents([.fraction(0.3)])
                    }

                }
                .padding()

                ScrollView(.horizontal) {
                    HStack(spacing: 6) {
                        Button {
                            selectedCategory = nil
                        } label: {
                            TagView(tag: StringTag(tagText: "전체 보기"), color: selectedCategory == nil ? Color.midnightSteel : .gray)
                                .padding(.horizontal, 8)
                        }

                        ForEach(sortedCategoriesByCount, id: \.self) { category in
                            Button {
                                selectedCategory = category
                            } label: {
                                TagView(tag: category, color: selectedCategory == category ? Color.midnightSteel : .gray)
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
                        .font(.cafe24SsurroundAir(size: 16))
                        .padding(.vertical, 4)
                    ) {
                        ForEach(filteredRetrospects(), id: \.self) { retrospect in
                            HStack {
                                Text(retrospect.content ?? "")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.cafe24SsurroundAir(size: 16))

                                Text(formattedDate(retrospect.date))
                                    .foregroundStyle(.gray)
                                    .font(.cafe24SsurroundAir(size: 16))
                            }
                            .padding(.vertical, 4)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedDate = retrospect.date
                            }
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
