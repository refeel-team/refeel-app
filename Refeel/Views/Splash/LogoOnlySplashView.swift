//
//  LogoOnlySplashView.swift
//  Refeel
//
//  Created by Abel on 5/15/25.
//

import SwiftUI

// 로고만 표시하고 종료되는 스플래시 뷰

struct LogoOnlySplashView: View {
    @Binding var isActive: Bool
    var body: some View {
        ZStack {
            Color("splashBackground")
                .edgesIgnoringSafeArea(.all)

            Image("refeel")
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.isActive = false
            }
        }
    }
}

#Preview {
    LogoOnlySplashView(isActive: .constant(true))
}
