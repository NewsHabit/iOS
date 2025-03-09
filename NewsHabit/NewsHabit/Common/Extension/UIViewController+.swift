//
//  UIViewController+.swift
//  NewsHabit
//
//  Created by 지연 on 3/2/25.
//

import UIKit

extension UIViewController {
    func showAlert(_ type: AlertType, completion: (() -> Void)? = nil) {
        let alertViewController = AlertViewController(type: type, actionCompletion: completion)
        present(alertViewController, animated: false)
    }
}
