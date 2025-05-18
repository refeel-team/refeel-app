//
//  StatisticsView.swift
//  Refeel
//
//  Created by hyunMac on 5/12/25.
//

import SwiftUI
import SwiftData

struct StatisticsView: View {
    @StateObject private var viewModel = StatisticsViewModel()

    @Query var retrospects: [Retrospect]
    @Environment(\.colorScheme) var colorScheme
    


    var body: some View {
        NavigationStack {
            VStack {
                HStack { // 타이틀 제목, 년도, 월 선택!!
                    Text("하루 기록들")
                        .bold()
                        .font(.cafe24SsurroundAir(size: 16))

                    Spacer()

                    Button {
                        viewModel.isYearSheetPresented.toggle()
                    } label: {
                        HStack(spacing: 6) {
                            Text(String(format: "%d년", viewModel.selectedYear))
                                .font(.cafe24SsurroundAir(size: 10))
                                .foregroundStyle(colorScheme == .dark ? Color.powderCloudBlue : Color.twilightNavy)

                            Image(systemName: "chevron.down")
                                .imageScale(.small)
                                .font(.cafe24SsurroundAir(size: 10))
                                .foregroundStyle(colorScheme == .dark ? Color.powderCloudBlue : Color.twilightNavy)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    colorScheme == .dark ? Color.powderCloudBlue : Color.twilightNavy,
                                    lineWidth: 1)
                        }
                    }

                    .sheet(isPresented: $viewModel.isYearSheetPresented) {
                        VStack {
                            // 연도 선택 Picker
                            Picker("연도", selection: $viewModel.selectedYear) {
                                ForEach(2015...2035, id: \.self) { year in
                                    Text(String(format: "%d년", year)) // 연도 표시
                                        .font(.cafe24SsurroundAir(size: 16))
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(height: 150)

                            Button{
                                viewModel.isYearSheetPresented = false
                            } label : {
                                Text("확인")
                                    .font(.cafe24SsurroundAir(size: 16))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 40)
                                    .background(Color.primaryColor)
                                    .cornerRadius(12)
                                    .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                            }
                        }
                        .padding()
                        .presentationDetents([.fraction(0.3)])
                    }

                    Button {
                        viewModel.isMonthSheetPresented.toggle()
                    } label: {
                        HStack(spacing: 6) {
                            Text("\(viewModel.selectedMonth)월")
                                .foregroundStyle(colorScheme == .dark ? Color.powderCloudBlue : Color.twilightNavy)
                                .font(.cafe24SsurroundAir(size: 10))

                            Image(systemName: "chevron.down")
                                .imageScale(.small)
                                .font(.cafe24SsurroundAir(size: 10))
                                .foregroundStyle(colorScheme == .dark ? Color.powderCloudBlue : Color.twilightNavy)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    colorScheme == .dark ? Color.powderCloudBlue : Color.twilightNavy,
                                    lineWidth: 1)
                        }
                    }
                    .sheet(isPresented: $viewModel.isMonthSheetPresented) {
                        VStack {
                            // 연도 선택 Picker
                            Picker("월", selection: $viewModel.selectedMonth) {
                                ForEach(1...12, id: \.self) { month in
                                    Text("\(month)월")
                                        .font(.cafe24SsurroundAir(size: 16))
                                }
                            }
                            .pickerStyle(WheelPickerStyle()) // 회전형 Picker
                            .frame(height: 150)

                            Button{
                                viewModel.isMonthSheetPresented = false
                            } label : {
                                Text("확인")
                                    .font(.cafe24SsurroundAir(size: 16))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 40)
                                    .background(Color.primaryColor)
                                    .cornerRadius(12)
                                    .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                            }
                        }
                        .padding()
                        .presentationDetents([.fraction(0.3)])
                    }

                }
                .padding()

                ScrollView(.horizontal) {
                    HStack(spacing: 6) {
                        Button {
                            viewModel.selectedCategory = nil
                        } label: {
                            TagView(tag: StringTag(tagText: "전체 보기"), color: viewModel.selectedCategory == nil ? Color.midnightSteel : .gray)
                                .padding(.horizontal, 8)
                        }
                        
                        ForEach(viewModel.sortedCategoriesByCount(retrospects: retrospects), id: \.self) { category in
                            Button {
                                viewModel.selectedCategory = category
                            } label: {
                                TagView(tag: category, color: viewModel.selectedCategory == category ? Color.midnightSteel : .gray)
                            }
                        }
                        .padding(.trailing, 13)
                    }
                }
                .scrollIndicators(.hidden)

                Spacer()

                List {
                    // 카테고리 개수 표시 - Section header에 넣기
                    Section (header:
                                Text("\(viewModel.selectedCategory?.rawValue ?? "전체"): \(viewModel.filteredRetrospects(retrospects: retrospects).count)개")
                            .font(.cafe24SsurroundAir(size: 16))
                            .padding(.vertical, 4)
                    ) {
                        ForEach(viewModel.filteredRetrospects(retrospects: retrospects), id: \.self) { retrospect in
                            HStack {
                                Text(retrospect.content ?? "")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.cafe24SsurroundAir(size: 16))
                                
                                Text(formattedDate(retrospect.date))
                                    .foregroundStyle(.gray)
                                    .font(.cafe24SsurroundAir(size: 16))
                            }
                            .padding(.vertical, 4)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewModel.selectedDate = retrospect.date
                            }
                        }
                    }
                }
                .padding(.horizontal, -20)
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                .background(.background)
            }
            .navigationDestination(item: $viewModel.selectedDate) { date in
                RetrospectDetailView(selectedDate: date)
            }
        }
    }
}

#Preview {
    StatisticsView()
}
