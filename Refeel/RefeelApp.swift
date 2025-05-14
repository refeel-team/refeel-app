//
//  RefeelApp.swift
//  Refeel
//
//  Created by Abel on 5/12/25.
//

import SwiftUI
import SwiftData

@main
struct RefeelApp: App {
    @State private var isSplashActive = true

    var body: some Scene {
        WindowGroup {
            if isSplashActive {
                SplashView(isActive: $isSplashActive)
            } else {
                MainTabView()
            }
        }
        .modelContainer(for: Retrospect.self)
    }
}
