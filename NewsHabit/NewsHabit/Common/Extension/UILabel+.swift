//
//  UILabel+.swift
//  NewsHabit
//
//  Created by 지연 on 3/2/25.
//

import UIKit

extension UILabel {
    func setLineHeight(_ lineHeight: CGFloat) {
        guard let text = self.text else { return }
        
        let attributedString: NSMutableAttributedString
        if let existingAttributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: existingAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: text)
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.alignment = textAlignment
        
        let fullRange = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(
            .paragraphStyle, value: paragraphStyle, range: fullRange)
        
        attributedString.addAttribute(
            .baselineOffset, value: (lineHeight - font.lineHeight) / 2, range: fullRange
        )
        
        self.attributedText = attributedString
    }
}
