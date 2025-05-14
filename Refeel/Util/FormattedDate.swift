//
//  FormattedDate.swift
//  Refeel
//
//  Created by Abel on 5/14/25.
//

import SwiftUI

func formattedDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd"
    return formatter.string(from: date)
}
