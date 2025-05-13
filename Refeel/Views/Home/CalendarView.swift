//
//  CalendarView.swift
//  Refeel
//
//  Created by hyunMac on 5/12/25.
//

import SwiftUI

struct CalendarView: View {
    @State private var currentDate: Date = Date()

    var body: some View {
        VStack(spacing: 0) {
            // 월 이동 버튼, 타이틀
            HStack {
                Button {
                    currentDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                }

                Spacer()

                Text(dateFormatting(by: currentDate))
                    .font(.title2)
                    .fontWeight(.semibold)

                Spacer()

                Button {
                    currentDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.black)
                }
            }
            .padding(.horizontal, 40)
            .padding()

            //달력
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(["일","월","화","수","목","금","토"], id: \.self) { day in
                    Text(day)
                        .font(.title3)
                }
            }
            .padding(.top)
            .padding(.horizontal)

            LazyVGrid(columns: Array(repeating: GridItem(), count: 7),spacing: 34) {
                ForEach(generateCalendar(), id: \.self) { date in
                    VStack {
                        Text("\(Calendar.current.component(.day, from: date))")

                        Button {

                        } label: {
                            Text("감자")
                        }
                    }
                }
            }
            .padding()
        }
        Spacer()
    }

    // 달력 날짜 생성 메소드
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

    // 날짜 포메팅해서 반환해주는 메서드 (타이틀 출력용)
    func dateFormatting(by: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월"
        return dateFormatter.string(from: by)
    }
}

#Preview {
    CalendarView()
}
