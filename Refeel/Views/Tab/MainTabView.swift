//
//  MainTabView.swift
//  Refeel
//
//  Created by hyunMac on 5/13/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }

            StatisticsView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")
                }
        }
    }
}

#Preview {
    MainTabView()
}
