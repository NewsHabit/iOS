//
//  CategoryFilterCellModel.swift
//  NewsHabit
//
//  Created by 지연 on 3/25/25.
//

import Foundation

struct CategoryFilterCellModel: Hashable {
    let id = UUID()
    let filterName: String
    var isSelected: Bool
}
