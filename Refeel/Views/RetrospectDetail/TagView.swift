//
//  File.swift
//  Refeel
//
//  Created by Abel on 5/14/25.
//
import SwiftUI
import Foundation

protocol TagRepresentable {
    var tagText: String { get }
}

extension Category: TagRepresentable {
    var tagText: String { rawValue }
}

struct StringTag: TagRepresentable {
    let tagText: String
}

struct TagView<T: TagRepresentable>: View {
    let tag: T
    let color: Color

    var body: some View {
        HStack(spacing: 10) {
            Text(tag.tagText)
                .fontWeight(.semibold)
                .font(.cafe24SsurroundAir(size: 14))
        }
        .frame(height: 35)
        .foregroundStyle(.white)
        .padding(.horizontal, 10)
        .background {
            Capsule()
                .fill(color.gradient)
        }
    }
}


struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
            TagView(tag: Category.workout, color: .yellow)
            TagView(tag: StringTag(tagText: "카테고리 선택"), color: .yellow)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
