//
//  UIView+.swift
//  NewsHabit
//
//  Created by 지연 on 3/2/25.
//

import UIKit

extension UIView {
    // 색상을 이미지로 변환하는 함수
    func image(with color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
