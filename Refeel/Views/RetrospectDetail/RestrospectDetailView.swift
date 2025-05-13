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
                    Text("카테고리 선택")
                        .font(.headline)
                        .padding(.top)

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            Button {
                                selectedCategory = category
                                showCategorySheet = false
                            } label: {
                                Text(category.rawValue)
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(
                                        Capsule()
                                            .fill(Color.blue.opacity(0.1))
                                    )
                                    .foregroundColor(.blue)
                            }
                        }
                    }

                    Spacer()
                }
                .padding()
                .presentationDetents([.fraction(0.4), .medium])
            }

            Button {

            } label: {
                Text("저장하기")
            }
            .buttonStyle(.borderedProminent)
        }


    }
}

#Preview {
    RestrospectDetailView()
}
