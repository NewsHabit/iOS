//
//  TodayNewsView.swift
//  NewsHabit
//
//  Created by 지연 on 3/24/25.
//

import UIKit

final class TodayNewsView: UIView {
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPink.withAlphaComponent(0.1)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
