//
//  CustomMainTabView.swift
//  Refeel
//
//  Created by Abel on 5/15/25.
//

import SwiftUI

// 홈과 통계 화면을 전환하는 커스텀 하단 탭바 뷰

struct CustomMainTabView: View {
    @Environment(\.colorScheme) var colorScheme
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
            .padding(.bottom, 12)
            .background(colorScheme == .light ? Color.white : Color.white.opacity(0.1))
            .shadow(color: colorScheme == .light ? Color.black.opacity(0.1) : Color.white.opacity(0.08), radius: 4)

        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    CustomMainTabView()
}
