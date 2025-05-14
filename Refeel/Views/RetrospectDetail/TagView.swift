//
//  File.swift
//  Refeel
//
//  Created by Abel on 5/14/25.
//
import SwiftUI


func TagView(_ tag: Category, _ color: Color) -> some View {
    HStack(spacing: 10) {
        Text(tag.rawValue)
            .font(.callout)
            .fontWeight(.semibold)
    }
    .frame(height: 35)
    .foregroundStyle(.white)
    .padding(.horizontal, 10)
    .background {
        Capsule()
            .fill(color.gradient)
    }
}
