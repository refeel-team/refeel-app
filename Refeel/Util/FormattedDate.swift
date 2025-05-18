//
//  FormattedDate.swift
//  Refeel
//
//  Created by Abel on 5/14/25.
//

import SwiftUI

// Date를 "YYYY-MM-dd" 형식의 문자열로 변환하는 함수

func formattedDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd"
    return formatter.string(from: date)
}
