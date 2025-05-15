//
//  LogoOnlySplashView.swift
//  Refeel
//
//  Created by Abel on 5/15/25.
//

import SwiftUI

struct LogoOnlySplashView: View {
    @Binding var isActive: Bool
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
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
