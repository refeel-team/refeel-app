//
//  FlowLayout.swift
//  Refeel
//
//  Created by Abel on 5/13/25.
//

import SwiftUI

// 서브뷰들을 줄 단위로 자동 배치하는 커스텀 레이아웃

struct FlowLayout: Layout {
    var spacing: CGFloat? = nil
    var lineSpacing: CGFloat = 10.0

    // 캐시에 저장할 서브뷰 크기 및 간격
    struct Cache {
        var sizes: [CGSize] = []
        var spacing: [CGFloat] = []
    }

    func makeCache(subviews: Subviews) -> Cache {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let spacing: [CGFloat] = subviews.indices.map { index in
            guard index != subviews.count - 1 else {
                return 0
            }

            return subviews[index].spacing.distance(
                to: subviews[index+1].spacing,
                along: .horizontal
            )
        }

        return Cache(sizes: sizes, spacing: spacing)
    }

     // 전체 레이아웃의 크기 계산
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Cache
    ) -> CGSize {
        var totalHeight = 0.0
        var totalWidth = 0.0

        var lineWidth = 0.0
        var lineHeight = 0.0

        for index in subviews.indices {
            if lineWidth + cache.sizes[index].width > proposal.width ?? 0 {
                totalHeight += lineHeight + lineSpacing // 줄 간격 추가
                lineWidth = cache.sizes[index].width
                lineHeight = cache.sizes[index].height
            } else {
                lineWidth += cache.sizes[index].width + (spacing ?? cache.spacing[index])
                lineHeight = max(lineHeight, cache.sizes[index].height)
            }

            totalWidth = max(totalWidth, lineWidth)
        }

        totalHeight += lineHeight

        return .init(width: totalWidth, height: totalHeight)
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Cache
    ) {
        var lineX = bounds.minX
        var lineY = bounds.minY
        var lineHeight: CGFloat = 0

        for index in subviews.indices {
            if lineX + cache.sizes[index].width > (proposal.width ?? 0) {
                lineY += lineHeight + lineSpacing // 줄 간격 추가
                lineHeight = 0
                lineX = bounds.minX
            }

            let position = CGPoint(
                x: lineX + cache.sizes[index].width / 2,
                y: lineY + cache.sizes[index].height / 2
            )

            lineHeight = max(lineHeight, cache.sizes[index].height)
            lineX += cache.sizes[index].width + (spacing ?? cache.spacing[index])

            subviews[index].place(
                at: position,
                anchor: .center,
                proposal: ProposedViewSize(cache.sizes[index])
            )
        }
    }
}
