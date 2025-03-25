//
//  DayCellModel.swift
//  NewsHabit
//
//  Created by 지연 on 3/25/25.
//

import Foundation

struct DayCellModel: Hashable {
    let id = UUID()
    let day: String?
    let type: DayCellType
    
    init(day: String? = nil, type: DayCellType) {
        self.day = day
        self.type = type
    }
}
