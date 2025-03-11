//
//  UISwitch+.swift
//  NewsHabit
//
//  Created by 지연 on 3/11/25.
//

import Combine
import UIKit

extension UISwitch {
    var isOnPublisher: AnyPublisher<Bool, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.isOn)
            .eraseToAnyPublisher()
    }
}
