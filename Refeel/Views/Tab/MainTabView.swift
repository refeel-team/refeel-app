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
                    Image(systemName: "house")
                    Text("홈")
                }

            StatisticsView()
                .tabItem {
                    Image(systemName: "newspaper.fill")
                    Text("통계")
                }
        }
    }
}

#Preview {
    MainTabView()
}
