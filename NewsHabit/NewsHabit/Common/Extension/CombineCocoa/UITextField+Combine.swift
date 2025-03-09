//
//  UITextField+Combine.swift
//  NewsHabit
//
//  Created by 지연 on 3/2/25.
//

import Combine
import UIKit

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        Publishers.Merge(
            publisher(for: \.text).compactMap { $0 },
            NotificationCenter.default.publisher(
                for: UITextField.textDidChangeNotification,
                object: self
            )
            .compactMap { ($0.object as? UITextField)?.text }
        )
        .removeDuplicates()
        .eraseToAnyPublisher()
    }
}
