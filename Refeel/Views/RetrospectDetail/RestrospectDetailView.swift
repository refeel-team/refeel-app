//
//  RestrospectDetailView.swift
//  Refeel
//
//  Created by hyunMac on 5/12/25.
//

import SwiftUI

struct RestrospectDetailView: View {
    @State private var text: String = ""
    @State private var selectedCategory: Category? = nil
    @State private var showCategorySheet = false

    let categories = Category.allCases


    var body: some View {
        Button {
            showCategorySheet = true
        } label: {
            Text(selectedCategory?.rawValue ?? "카테고리를 선택해주세요.")
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
                        .font(.title3)
                    Text("딱 한 개만 고르실 수 있어요")
                        .font(.headline)
                        .foregroundStyle(.gray)

                    FlowLayout(spacing: 10, lineSpacing: 10) {
                        ForEach(categories, id: \.self) { category in
                            TagView(category, selectedCategory == category ? .blue : .gray)
                                .onTapGesture {
                                    selectedCategory = category
                                    showCategorySheet = false
                                }
                        }
                    }
                    .padding()

                    Spacer()
                }
                .padding(.top, 40)
                .presentationDetents([.fraction(0.8), .medium])
            }
            .padding()
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
                            .fill(selectedCategory == nil ? Color(.gray) : Color(.black))
                    }
            }
            .disabled(selectedCategory == nil)
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
