//
//  SplashView.swift
//  Refeel
//
//  Created by hyunMac on 5/12/25.
//

import SwiftUI

struct FirstLaunchedSplashView: View {
    @Binding var isActive: Bool
    @Binding var isFirstLaunch: Bool
    @State private var textToShow = ""
    @State private var isTyping = true
    @State private var isErasing = false
    @State private var isSecondTextShowing = false

    private let firstText = "Refeel"
    private let secondText = "다시 마주하다"

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack {
                // 회고 아이콘
                Image("refeel")
                    .padding(.bottom, 20)

                Text(textToShow)
                    .font(.cafe24SsurroundAir(size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .onAppear {
                        typeText()
                    }
            }
            // 시간 지나면 종료
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.isActive = false
                    self.isFirstLaunch = true
                }
            }
        }
    }

    func typeText() {
        var index = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { timer in
            if index < firstText.count {
                let currentIndex = firstText.index(firstText.startIndex, offsetBy: index)
                textToShow.append(firstText[currentIndex])
                index += 1
            } else {
                withAnimation(.easeIn(duration: 1.0).delay(1.0)) {
                    isErasing = true
                }
                timer.invalidate()
                eraseText()
            }
        }
        RunLoop.current.add(timer, forMode: .common)
    }

    // 지우개 함수
    func eraseText() {
        var index = textToShow.count
        let eraseTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if index > 0 {
                textToShow.removeLast()
                index -= 1
            } else {
                withAnimation(.easeIn(duration: 1.0)) {
                    isSecondTextShowing = true
                }
                timer.invalidate()
                typeSecondText()
            }
        }
        RunLoop.current.add(eraseTimer, forMode: .common)
    }

    // 두번째 타이핑
    func typeSecondText() {
        var index = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if index < secondText.count {
                let currentIndex = secondText.index(secondText.startIndex, offsetBy: index)
                textToShow.append(secondText[currentIndex])
                index += 1
            } else {
                timer.invalidate()
            }
        }
        RunLoop.current.add(timer, forMode: .common)
    }
}

struct FirstLaunchedSplashView_Previews: PreviewProvider {
    static var previews: some View {
        FirstLaunchedSplashView(isActive: .constant(true), isFirstLaunch: .constant(true))
    }
}
