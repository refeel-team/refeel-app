//
//  CustomMainTabView.swift
//  Refeel
//
//  Created by Abel on 5/15/25.
//

import SwiftUI

struct CustomMainTabView: View {
    @State private var selectedIndex = 0

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch selectedIndex {
                case 0:
                    HomeView()
                case 1:
                    StatisticsView()
                default:
                    HomeView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            HStack {
                TabBarButton(
                    icon: "calendar",
                    title: "Calendar",
                    isSelected: selectedIndex == 0,
                    action: { selectedIndex = 0 }
                )
                TabBarButton(
                    icon: "list.bullet",
                    title: "List",
                    isSelected: selectedIndex == 1,
                    action: { selectedIndex = 1 }
                )
            }
            .padding(.vertical, 16)
            .background(Color.white.shadow(radius: 4))
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
