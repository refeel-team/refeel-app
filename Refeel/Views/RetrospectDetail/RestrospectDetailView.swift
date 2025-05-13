//
//  RestrospectDetailView.swift
//  Refeel
//
//  Created by hyunMac on 5/12/25.
//

import SwiftUI

struct RestrospectDetailView: View {
    @State private var text: String = ""

    //유진님
    var body: some View {
        Text("카테고리")
        Text("X")
        VStack(alignment: .leading) {
            Text("오늘의 회고")
                .font(.headline)

            TextEditor(text: $text)
                .frame(height: 200)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
        }
        .padding()
        Text("오늘 내가 팀에 기여한 것은 무엇인가요?")
        Text("어떤 것을 더 하면 내가 더 성장할 수 있을까요?")
        Text("내일의 todo-list")
        Button {

        } label: {
            Text("저장하기")
        }
        .buttonStyle(.borderedProminent)

    }
}

#Preview {
    RestrospectDetailView()
}
