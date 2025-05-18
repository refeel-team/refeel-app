//
//  Category.swift
//  Refeel
//
//  Created by Abel on 5/13/25.
//

import Foundation

enum Category: String, CaseIterable, Codable {
    case health = "건강"
    case workout = "운동"
    case study = "공부"
    case work = "업무"
    case rest = "휴식"
    case hobby = "취미"
    case travel = "여행"
    case family = "가족"
    case etc = "기타"
}
