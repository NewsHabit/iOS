//
//  UIFont+.swift
//  NewsHabit
//
//  Created by 지연 on 3/1/25.
//

import UIKit

extension UIFont {
    static func logo(size: CGFloat) -> UIFont {
        return UIFont(name: "WantedSans-Black", size: size)!
    }
    
    static func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Regular", size: size)!
    }
    
    static func medium(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Medium", size: size)!
    }
    
    static func semibold(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-SemiBold", size: size)!
    }
    
    static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Bold", size: size)!
    }
}
