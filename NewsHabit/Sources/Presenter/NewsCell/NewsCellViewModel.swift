//
//  NewsCellViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/19/24.
//

import Combine
import Foundation

class NewsCellViewModel {
    
    let newsItem: NewsItem
    
    init(newsItem: NewsItem) {
        self.newsItem = newsItem
    }
    
    var title: String? {
        newsItem.title
    }
    
    var description: String? {
        newsItem.description
    }
    
    var category: String? {
        newsItem.category
    }
    
    @Published var isRead: Bool = false
    
}