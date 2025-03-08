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
}
