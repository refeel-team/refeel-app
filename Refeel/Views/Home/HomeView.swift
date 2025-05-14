//
//  HomeView.swift
//  Refeel
//
//  Created by hyunMac on 5/12/25.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedDate: Date?

    var body: some View {
        NavigationStack {
            VStack {
                CalendarView(selectedDate: $selectedDate)
            }
            .navigationDestination(item: $selectedDate) { date in
                let dayDate = Calendar.current.startOfDay(for: date)
                // 선택된 날짜를 시간 부분만 0으로 만들어서 전달
                // 예시 Date 타입 "2025-05-14 00:00:00" 으로 전달됨
                // 타임존 
                RetrospectDetailView(selectedDate: dayDate)
            }
        }
    }
}


#Preview {
    HomeView()
}
