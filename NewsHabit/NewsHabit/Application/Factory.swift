//
//  Factory.swift
//  NewsHabit
//
//  Created by 지연 on 3/9/25.
//

import UIKit

final class Factory {
    static func makeCategoryViewController() -> CategoryViewController {
        let viewModel = CategoryViewModel()
        let viewController = CategoryViewController(viewModel: viewModel)
        return viewController
    }
    
    static func makeDailyGoalViewController() -> DailyGoalViewController {
        let viewModel = DailyGoalViewModel()
        let viewController = DailyGoalViewController(viewModel: viewModel)
        return viewController
    }
}
