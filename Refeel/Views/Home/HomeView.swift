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
            VStack(spacing: 0) {
                CalendarView(selectedDate: $selectedDate)
            }
            .navigationDestination(item: $selectedDate) { date in
                let dayDate = Calendar.current.startOfDay(for: date)
                RetrospectDetailView(selectedDate: dayDate)
            }
        }
    }
}


#Preview {
    HomeView()
}
