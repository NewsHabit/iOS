//
//  UIButton+Combine.swift
//  NewsHabit
//
//  Created by 지연 on 3/2/25.
//

import Combine
import UIKit

public extension UIButton {
    var tapPublisher: AnyPublisher<Void, Never> {
        controlEventPublisher(for: .touchUpInside)
    }
}
