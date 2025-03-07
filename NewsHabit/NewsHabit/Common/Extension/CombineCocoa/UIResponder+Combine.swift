//
//  UIResponder+Combine.swift
//  NewsHabit
//
//  Created by 지연 on 3/2/25.
//

import Combine
import UIKit

extension UIResponder {
    var keyboardShowPublisher: AnyPublisher<CGFloat, Never> {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
            .map { $0.cgRectValue.height }
            .eraseToAnyPublisher()
    }
    
    var keyboardHidePublisher: AnyPublisher<Void, Never> {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in }
            .eraseToAnyPublisher()
    }
}
