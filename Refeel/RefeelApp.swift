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
    // 앱 스토리지로 첫 실행 유저 인지 판별
    @AppStorage("hasLaunchedBefore") private var isFirstLaunchCompleted = false
    @State private var isSplashActive = true

    var body: some Scene {
        WindowGroup {
            if isSplashActive {
                if isFirstLaunchCompleted {
                    // 첫 실행 유저가 아니면 로고 스플래시 화면 , 1.5 초
                    LogoOnlySplashView(isActive: $isSplashActive)
                } else {
                    // 첫 실행 유저면 글 쓰는 스플래시 화면 , 3초
                    FirstLaunchedSplashView(isActive: $isSplashActive, isFirstLaunch: $isFirstLaunchCompleted)
                }
            } else {
                CustomMainTabView()
                    .dynamicTypeSize(.xSmall ... .xLarge)
            }
        }
        .modelContainer(for: Retrospect.self)
    }
}
