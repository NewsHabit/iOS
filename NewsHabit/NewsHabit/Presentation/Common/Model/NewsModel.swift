//
//  NewsModel.swift
//  NewsHabit
//
//  Created by 지연 on 3/24/25.
//

import Foundation

struct NewsModel: Hashable {
    let title: String
    let description: String
    let category: Category
    var isUnread: Bool
    
    init(title: String, description: String, category: Category, isUnread: Bool = false) {
        self.title = title
        self.description = description
        self.category = category
        self.isUnread = isUnread
    }
}
