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
    @StateObject private var viewModel = CalendarViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // 월 이동 버튼, 타이틀
            HStack {
                Button {
                    withAnimation {
                        viewModel.moveMonth(by: -1)
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.primary)
                        .fontWeight(.bold)
                }
                Spacer()

                Text(viewModel.monthTitle)
                    .font(.cafe24SsurroundAir(size: 16))
                    .fontWeight(.semibold)
                Spacer()

                Button {
                    withAnimation {
                        viewModel.moveMonth(by: 1)
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color.primary)
                        .font(.cafe24SsurroundAir(size: 16))
                        .fontWeight(.bold)
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
                ForEach(viewModel.generateCalendar(), id: \.self) { date in
                    let isToday = Calendar.current.isDateInToday(date)
                    let isCurrentMonth = Calendar.current.isDate(date, equalTo: viewModel.currentDate, toGranularity: .month)
                    let isFuture = date > Date()

                    VStack(spacing: 6) {
                        if isCurrentMonth {
                            ZStack {
                                if isToday {
                                    Circle()
                                        .frame(width: 24, height: 24)
                                        .foregroundStyle(Color.primaryColor)
                                }

                                Text("\(Calendar.current.component(.day, from: date))")
                                    .font(.cafe24SsurroundAir(size: 16))
                                    .foregroundStyle(isToday ? Color.white : (isFuture ? Color.primary.opacity(0.5) : Color.primary))
                                    .fontWeight(isToday ? .bold : .regular)
                            }
                            .frame(height: 30)

                            if !isFuture {
                                if viewModel.isWritten(date: date, retrospects: retrospects) {
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
                                            .foregroundStyle(isToday ? Color.primaryColor : Color.gray.opacity(0.4))
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

#Preview {
    CalendarView(selectedDate: .constant(Date()))
}
