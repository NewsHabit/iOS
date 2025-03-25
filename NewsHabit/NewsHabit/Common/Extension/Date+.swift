//
//  Date+.swift
//  NewsHabit
//
//  Created by 지연 on 3/25/25.
//

import Foundation

extension Date {
    func formatAsFullDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "오전"
        dateFormatter.pmSymbol = "오후"
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 a hh:00 기준"
        return dateFormatter.string(from: self)
    }
}
