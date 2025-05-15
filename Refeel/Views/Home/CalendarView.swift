//
//  CalendarView.swift
//  Refeel
//
//  Created by hyunMac on 5/12/25.
//

import SwiftUI
import SwiftData


struct CalendarView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.modelContext) private var context
    @Query private var retrospects: [Retrospect]
    @Binding var selectedDate: Date?
    @State private var currentDate: Date = Date()

    var body: some View {
        VStack(spacing: 0) {
            // 월 이동 버튼, 타이틀
            HStack {
                Button {
                    withAnimation {
                        currentDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.primary)
                        .fontWeight(.bold)
                }
                Spacer()

                Text(dateFormatting(by: currentDate))
                    .font(.cafe24SsurroundAir(size: 16))
                    .fontWeight(.semibold)
                Spacer()

                Button {
                    withAnimation {
                        currentDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color.primary)
                        .font(.cafe24SsurroundAir(size: 16))
                }
            }
            .padding(.horizontal, 40)
            .padding(.vertical)

            //달력
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(["일","월","화","수","목","금","토"], id: \.self) { day in
                    Text(day)
                        .font(.cafe24SsurroundAir(size: 16))
                }
            }
            .padding(.top, 8)
            .padding(.horizontal)

            LazyVGrid(columns: Array(repeating: GridItem(), count: 7),spacing: 16) {
                ForEach(generateCalendar(), id: \.self) { date in
                    let isToday = Calendar.current.isDateInToday(date)
                    let isCurrentMonth = Calendar.current.isDate(date, equalTo: currentDate, toGranularity: .month)
                    let isFuture = date > Date()

                    VStack(spacing: 6) {
                        if isCurrentMonth {
                            ZStack {
                                if isToday {
                                    Circle()
                                        .frame(width: 24, height: 24)
                                        .foregroundStyle(Color.blue.opacity(0.2))
                                }

                                Text("\(Calendar.current.component(.day, from: date))")
                                    .font(.cafe24SsurroundAir(size: 16))
                                    .foregroundStyle(isToday ? .blue : (isFuture ? Color.primary.opacity(0.5) : Color.primary))
                                    .fontWeight(isToday ? .bold : .regular)
                            }
                            .frame(height: 30)

                            if !isFuture {
                                if isWritten(date: date) {
                                    Button {
                                        selectedDate = date
                                    } label: {
                                        Image("refeel")
                                            .resizable()
                                            .frame(width: 38, height: 38)
                                    }
                                } else {
                                    Button {
                                        selectedDate = date
                                    } label: {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 38, height: 38)
                                            .foregroundStyle(isToday ? Color.blue.opacity(0.8) : Color.gray.opacity(0.4))
                                            .shadow(radius: 1, y: 2)
                                    }
                                }
                            } else {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 38, height: 38)
                                    .foregroundStyle(colorScheme == .light ? Color.black.opacity(0.5) : Color.gray.opacity(0.2))
                                    .shadow(radius: 1, y: 2)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        Spacer()
    }
}

extension CalendarView {
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

    // date를 받고 그 데이터베이스에 조회해서 트루펄스 반환하도록함
    func isWritten(date: Date) -> Bool {
        let dateforSearch = Calendar.current.startOfDay(for: date)
        let isExist = retrospects.contains(where: {
            Calendar.current.isDate($0.date, inSameDayAs: dateforSearch)
        })
        return isExist

        // 프리뷰에서 아이콘 보고싶을때 위에 내부코드 전부 주석처리하시고
        // 아래 주석코드 활성화 하시면 프리뷰로 확인 가능합니다.
        //let day = Calendar.current.component(.day, from: date)
        //return day % 4 == 0 ? true : false
    }
}

#Preview {
    CalendarView(selectedDate: .constant(Date()))
}
