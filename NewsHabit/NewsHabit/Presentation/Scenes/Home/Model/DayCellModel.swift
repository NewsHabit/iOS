//
//  DayCellModel.swift
//  NewsHabit
//
//  Created by 지연 on 3/25/25.
//

import Foundation

struct DayCellModel: Hashable {
    let id = UUID()
    let day: String
    let isRead: Bool
    let isToday: Bool
}
