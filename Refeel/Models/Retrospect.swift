//
//  Retrospect.swift
//  Refeel
//
//  Created by hyunMac on 5/12/25.
//

import Foundation
import SwiftData

@Model
class Retrospect: Identifiable {
    var id: UUID // UUID
    var date: Date // 작성날짜
    var content: String? // 작성글
    var category: Category? // 카테고리

    // 카테고리의 경우, nil일 수 있음
    init(date: Date, content: String? = "", category: Category? = nil) {
        self.id = UUID()
        self.date = Calendar.current.startOfDay(for: date)
        self.content = content
        self.category = category
    }
}
