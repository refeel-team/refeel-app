//
//  RestrospectDetailView.swift
//  Refeel
//
//  Created by hyunMac on 5/12/25.
//

import SwiftUI
import SwiftData

struct RetrospectDetailView: View {
    @State private var text: String = ""
    @State private var selectedCategory: Category? = nil
    @State private var showCategorySheet = false
    let selectedDate: Date?
    // 쓰기 모드인지 보기 모드인지 분기
    @State private var isViewing: Bool = false
    // 조회 쿼리문
    @Query(sort: \Retrospect.date, order: .reverse) private var retrospects: [Retrospect]

    // 저장소 위치
    @Environment(\.modelContext) private var context
    // 화면 pop하기 위한 dismiss
    @Environment(\.dismiss) private var dismiss

    let categories = Category.allCases

    var body: some View {
        // 글 보기 화면
        // isViewing으로 쓰기/보기 모드 분류
        HStack {
            if let date = selectedDate {
                Text(formattedDate(date))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Button {
                showCategorySheet = true
            } label: {
                Text(selectedCategory?.rawValue ?? "카테고리 선택")
                    .font(.subheadline)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(6)
            }
            Spacer()
        }
        .padding(.top, 16)
        .padding(.horizontal)

        VStack(alignment: .leading) {
            Text("오늘의 아쉬웠던 점은 무엇이었나요?")
                .font(.headline)
            TextEditor(text: $text)
                .frame(height: 200)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
        }
        .onAppear {
            guard let selectedDate else { return }

            if let retrospectData = retrospects.first(where: { Calendar.current.isDate($0.date, inSameDayAs: selectedDate)
            }) {
                text = retrospectData.content ?? ""
                selectedCategory = retrospectData.category
                isViewing = true
            } else {
                isViewing = false
            }
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

        ZStack {
            Button {
                // TODO: 컨텐츠가 비어있을때도 유저 알림 필요
                guard let selectedCategory else { return }
                // 카테고리 선택 안된경우 버튼 동작 안되도록, 나중에 메세지로 표시하거나 해서 유저한태 알려줄것 필요

                let dateForSearch = Calendar.current.startOfDay(for: selectedDate ?? Date())
                // 선택된 날짜 가지고 오기 무조건 가지고 와지는데 옵셔널이라 안가지고 와지면
                // 기본 Date넣기

                if let existing = retrospects.first(where: { ret in
                    Calendar.current.isDate(ret.date, inSameDayAs: dateForSearch)
                }) {
                    // 데이터가 조회된 경우 , 조회된 곳에 데이터 업데이트. save필요
                    existing.content = text
                    existing.category = selectedCategory
                } else {
                    // 데이터가 조회되지 않은 경우
                    let retrospect = Retrospect(date: selectedDate ?? Date(), content: text, category: selectedCategory)
                    // 셀렉티드 데이터 일치 필요,옵셔널("??") 해결 해야함.
                    context.insert(retrospect)
                }
                do {
                    try context.save()
                } catch {
                    print("저장 에러 발생")
                    // 나중에 다시 저장 관련해서 에러처리 필요
                }
                dismiss()
            } label: {
                Text(isViewing ? "수정하기" : "저장하기")
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isViewing {
                    Button {
                        // 삭제 로직 추가
                        print("🗑️ 삭제")
                    } label: {
                        Text("삭제")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
    
}

#Preview {
    RetrospectDetailView(selectedDate: Date())
}
