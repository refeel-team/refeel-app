//
//  RestrospectDetailView.swift
//  Refeel
//
//  Created by hyunMac on 5/12/25.
//

import SwiftUI
import SwiftData

struct RetrospectDetailView: View {
    @StateObject private var viewModel = RetrospectDetailViewModel()
    @State private var showCategorySheet = false
    let selectedDate: Date?
    @Query(sort: \Retrospect.date, order: .reverse) private var retrospects: [Retrospect]
    @State private var showEmptyContentAlert = false
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    let categories = Category.allCases
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                if let date = selectedDate {
                    Label {
                        Text(formattedDate(date))
                            .foregroundColor(.primary)
                            .font(.cafe24SsurroundAir(size: 12))
                            .fixedSize(horizontal: false, vertical: true)
                    } icon: {
                        Image(systemName: "calendar")
                            .foregroundColor(.primary)
                    }
                    .layoutPriority(1)
                }
                Button {
                    showCategorySheet = true
                } label: {
                    HStack {
                        if let category = viewModel.selectedCategory {
                            TagView(tag: category, color: Color.primaryColor)
                        } else {
                            TagView(tag: StringTag(tagText: "카테고리를 선택 해주세요"), color: Color.primaryColor)
                        }
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                }
                .fixedSize()
                .buttonStyle(PlainButtonStyle())
                Spacer()
            }
            .padding(.top, 16)
            .padding(.horizontal)
            
            
            VStack(alignment: .leading) {
                Text("오늘의 아쉬웠던 점은 무엇이었나요?")
                    .font(.cafe24SsurroundAir(size: 16))
                TextEditor(text: $viewModel.text)
                    .frame(height: 200)
                    .padding()
                    .font(.cafe24SsurroundAir(size: 16))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
            }
            .onAppear {
                viewModel.load(selectedDate: selectedDate, retrospects: retrospects)
            }
            //            .padding()
            .sheet(isPresented: $showCategorySheet) {
                VStack(spacing: 16) {
                    Text("내 하루에 담을 키워드를 골라주세요.")
                        .font(.title3)
                    Text("딱 한 개만 고르실 수 있어요")
                        .font(.headline)
                        .foregroundStyle(.gray)
                    
                    FlowLayout(spacing: 10, lineSpacing: 10) {
                        ForEach(categories, id: \.self) { category in
                            TagView(tag: category, color: viewModel.selectedCategory == category ? Color.primaryColor : .gray)
                                .onTapGesture {
                                    viewModel.selectedCategory = category
                                    showCategorySheet = false
                                }
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
                .padding(.top, 40)
                .presentationDetents([.fraction(0.3)])
            }
            .padding()
        }
        
        Spacer()
        
        // 저장 또는 수정 버튼
        ZStack {
            Button {
                // TODO: 컨텐츠가 비어있을때도 유저 알림 필요
                if !viewModel.canSave {
                    showEmptyContentAlert = true
                    return
                }
                
                do {
                    try viewModel.save(selectedDate: selectedDate, retrospects: retrospects, context: context)
                    dismiss()
                } catch {
                    print("저장 에러 발생: \(error.localizedDescription)")
                }
            } label: {
                Text(viewModel.isViewing ? "수정하기" : "저장하기")
                    .font(.cafe24SsurroundAir(size: 16))
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(viewModel.selectedCategory == nil ? Color(.gray) : Color(Color.primaryColor))
                    }
            }
            .disabled(viewModel.selectedCategory == nil)
            .padding()
        }
        .padding(.vertical, 20)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.primary)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                if viewModel.isViewing {
                    Button {
                        do {
                            try viewModel.delete(selectedDate: selectedDate, retrospects: retrospects, context: context)
                            dismiss()
                        } catch {
                            print("회고 삭제 실패 \(error.localizedDescription)" )
                        }
                    } label: {
                        Text("삭제")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .alert("내용을 입력해주세요", isPresented: $showEmptyContentAlert) {
            Button("확인", role: .cancel) {}
        } message: {
            Text("오늘의 아쉬웠던 점을 기록해주세요.")
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    RetrospectDetailView(selectedDate: Date())
}
