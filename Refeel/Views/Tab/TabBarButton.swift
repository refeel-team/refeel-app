//
//  TabBarButton.swift
//  Refeel
//
//  Created by Abel on 5/15/25.
//

import SwiftUI

struct TabBarButton: View {
    @Environment(\.colorScheme) var colorScheme
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .regular))
                Text(title)
                    .font(.cafe24SsurroundAir(size: 14))
            }
            .foregroundColor(
                isSelected
                ? (colorScheme == .light ? Color.primaryColor : .white) : (colorScheme == .light ? Color.gray: Color.white.opacity(0.6))
                )
            .frame(maxWidth: .infinity)
        }
    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 20) {
            TabBarButton(
                icon: "calendar",
                title: "Calendar",
                isSelected: true,
                action: {}
            )
            TabBarButton(
                icon: "list.bullet",
                title: "List",
                isSelected: false,
                action: {}
            )
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
