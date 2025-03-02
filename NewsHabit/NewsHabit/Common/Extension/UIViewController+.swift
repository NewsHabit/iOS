//
//  UIViewController+.swift
//  NewsHabit
//
//  Created by 지연 on 3/2/25.
//

import UIKit

extension UIViewController {
    func navigate(to viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
}
