//
//  Reusable.swift
//  NewsHabit
//
//  Created by 지연 on 3/7/25.
//

import UIKit

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
