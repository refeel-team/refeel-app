//
//  TabBarButton.swift
//  Refeel
//
//  Created by Abel on 5/15/25.
//

import SwiftUI

struct TabBarButton: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(Color.primaryColor)
                Text(title)
                    .font(.cafe24SsurroundAir(size: 14))
                    .foregroundStyle(Color.primaryColor)
            }
            .foregroundColor(isSelected ? Color.blue : Color.gray)
            .frame(maxWidth: .infinity)
        }
    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
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
