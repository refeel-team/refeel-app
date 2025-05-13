//
//  Category.swift
//  Refeel
//
//  Created by Abel on 5/13/25.
//

import Foundation


enum Category: String, CaseIterable, Codable {
    case 운동 = "운동"
    case 공부 = "공부"
    case 업무 = "업무"
    case 휴식 = "휴식"
    case 기타 = "기타"
}
