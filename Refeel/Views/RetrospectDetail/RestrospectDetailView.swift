//
//  RestrospectDetailView.swift
//  Refeel
//
//  Created by hyunMac on 5/12/25.
//

import SwiftUI
import SwiftData

struct RestrospectDetailView: View {
    @State private var text: String = ""
    @State private var selectedCategory: Category? = nil
    @State private var showCategorySheet = false
    
    @Environment(\.modelContext) private var context
    // 저장소 위치
    @Environment(\.dismiss) private var dismiss
    // 화면 pop하기 위한 dismiss
    
    let categories = Category.allCases
    
    var body: some View {
        Button {
            showCategorySheet = true
        } label: {
            Text(selectedCategory?.rawValue ?? "카테고리를 선택해주세요.")
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
        }
        
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
                guard let selectedCategory else { return }
                // 카테고리 선택 안된경우 버튼 동작 안되도록, 나중에 메세지로 표시하거나 해서 유저한태 알려줄것 필요
                let retrospect = Retrospect(date: Date(), content: text, category: selectedCategory)
                context.insert(retrospect)
                
                do {
                    try context.save()
                } catch {
                    print("저장 에러 발생")
                    // 나중에 다시 저장 관련해서 에러처리 필요
                }
                dismiss()
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
