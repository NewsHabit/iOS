//
//  HomeMenu.swift
//  NewsHabit
//
//  Created by 지연 on 3/20/25.
//

import Foundation

enum HomeMenu: CaseIterable {
    case todayNews
    case myRecord
    case bookmark
    
    var title: String {
        switch self {
        case .todayNews:
            "오늘의 뉴스"
        case .myRecord:
            "나의 기록"
        case .bookmark:
            "북마크"
        }
    }
}
