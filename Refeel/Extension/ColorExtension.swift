//
//  ColorExtension.swift
//  Refeel
//
//  Created by Abel on 5/15/25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
    static let primaryColor = Color(hex: "#FF5A28")

    static let iceMistBlue = Color(hex: "#F1F8FF")

    static let powderCloudBlue = Color(hex: "#D9EEFF")

    static let babyCreamBlue = Color(hex: "#C4E0FF")

    static let skyBreezeBlue = Color(hex: "#AECDF7")

    static let softCornflower = Color(hex: "#97B8E7")

    static let dustyPeriwinkle = Color(hex: "#809FD3")

    static let mutedDenim = Color(hex: "#6A87C0")

    static let slateSapphire = Color(hex: "#5671AD")

    static let deepPeriwinkle = Color(hex: "#425C9A")

    static let indigoSlate = Color(hex: "#324A83")

    static let midnightSteel = Color(hex: "#263A6C")

    static let twilightNavy = Color(hex: "#192B55")
}

