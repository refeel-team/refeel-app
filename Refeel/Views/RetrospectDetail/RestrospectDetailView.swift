//
//  RestrospectDetailView.swift
//  Refeel
//
//  Created by hyunMac on 5/12/25.
//

import SwiftUI

struct RestrospectDetailView: View {
    @State private var text: String = ""
    @State private var selectedCategory: Category = .운동
    @State private var showCategorySheet = false

    let categories = Category.allCases


    var body: some View {
        Button {
            showCategorySheet = true
        } label: {
            Text(selectedCategory.rawValue)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
            .cornerRadius(8)        }

        ScrollView {
            VStack(alignment: .leading) {
                Text("오늘의 성과는 무엇이었나요?")
                    .font(.headline)

                TextEditor(text: $text)
                    .frame(height: 200)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
            }
            .padding()
            .sheet(isPresented: $showCategorySheet) {
                VStack(spacing: 20) {
                    Text("내 하루에 담을 키워드를 골라주세요.")
                        .font(.headline)
                    Text("딱 한 개만 고르실 수 있어요")
                        .font(.headline)

                    FlowLayout(spacing: 10, lineSpacing: 10) {
                        ForEach(categories, id: \.self) { category in
                            TagView(category, selectedCategory == category ? .blue : .gray)
                                .onTapGesture {
                                    selectedCategory = category
                                }
                        }
                    }
                    .padding()

                    Spacer()
                }
                .padding()
                .presentationDetents([.fraction(0.8), .medium])
            }
        }
        ZStack {
            Button {

            } label: {
                Text("저장하기")
                    .fontWeight(.semibold)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.black.gradient)
                    }
            }
            .padding()
        }
    }
    @ViewBuilder
    func TagView(_ tag: Category, _ color: Color) -> some View {
        HStack(spacing: 10) {
            Text(tag.rawValue)
                .font(.callout)
                .fontWeight(.semibold)
        }
        .frame(height: 35)
        .foregroundStyle(.white)
        .padding(.horizontal, 10)
        .background {
            Capsule()
                .fill(color.gradient)
        }

    }
}

#Preview {
    RestrospectDetailView()
}
