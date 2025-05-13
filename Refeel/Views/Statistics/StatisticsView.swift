//
//  StatisticsView.swift
//  Refeel
//
//  Created by hyunMac on 5/12/25.
//

import SwiftUI

struct StatisticsView: View {
    @State private var selectedYear = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth = Calendar.current.component(.month, from: Date())
    
    @State private var selectedIndex: Int? = nil
    
    var body: some View {
            VStack {
                HStack { // 타이틀 제목, 년도, 월 선택
                    Text("통계 화면 제목")
                    
                    Spacer()
                    
                    Picker("연도", selection: $selectedYear) {
                        ForEach(2025...2027, id: \.self) { year in
                            Text(String(format: "%d년", year))
                        }
                    }
                    .buttonStyle(.bordered)
                    
                    Picker("월", selection: $selectedMonth) {
                        ForEach(1...12, id: \.self) { month in
                            Text("\(month)월")
                        }
                    }
                    .buttonStyle(.bordered)
                }
                
                ScrollView(.horizontal) { // 가로 스크롤 카테고리
                    HStack {
                        ForEach(1..<8, id: \.self) { index in
                            Button {
                                selectedIndex = index
                            } label: {
                                Capsule()
                                    .fill(selectedIndex == index ? .green : .green.opacity(0.6))
                                    .frame(width: 70, height: 30)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                
                Spacer()
                
                if selectedIndex == nil {
                    Label("카테고리를 선택해주세요.", systemImage: "bubble.right.circle.fill")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 350)
                } else {
                    ScrollView { // 통계 자료 목록
                        VStack(alignment: .trailing) {
                            Text("공부: 10개")
                                .bold()
                                .padding()
                            
                            HStack {
                                VStack {
                                    ForEach(1..<11) { _ in
                                        Text("글 1")
                                    }
                                }
                                
                                Spacer()
                                
                                VStack {
                                    ForEach(1..<11) { _ in
                                        Text("05-12")
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
            .padding()
    }
}

#Preview {
        StatisticsView()
}
