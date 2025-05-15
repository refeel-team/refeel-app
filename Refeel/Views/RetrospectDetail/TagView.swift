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
        HStack {
            Text(tag.tagText)
                .fontWeight(.semibold)
                .font(.cafe24SsurroundAir(size: 12))
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
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
            TagView(tag: StringTag(tagText: "카테고리를 선택해주세요"), color: .yellow)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
