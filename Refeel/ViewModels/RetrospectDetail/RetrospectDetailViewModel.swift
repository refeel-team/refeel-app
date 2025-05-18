//
//  RetrospectDetailViewModel.swift
//  Refeel
//
//  Created by hyunMac on 5/18/25.
//

import Foundation
import SwiftData

@MainActor
final class RetrospectDetailViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var selectedCategory: Category? = nil
    @Published var isViewing: Bool = false
    
    var canSave: Bool {
        return selectedCategory != nil && !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func load(selectedDate: Date?, retrospects: [Retrospect]) {
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
    
    func save(selectedDate: Date?, retrospects: [Retrospect], context: ModelContext) throws {
        guard canSave else { return }
        
        let dateForSearch = Calendar.current.startOfDay(for: selectedDate ?? Date())
        
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
        try context.save()
    }
    
    func delete(selectedDate: Date?, retrospects: [Retrospect], context: ModelContext) throws {
        guard let selectedDate else { return }
        guard let retrospectData = retrospects.first(where: { Calendar.current.isDate($0.date, inSameDayAs: selectedDate)
        }) else { return }
        
        context.delete(retrospectData)
        try context.save()
    }
}
