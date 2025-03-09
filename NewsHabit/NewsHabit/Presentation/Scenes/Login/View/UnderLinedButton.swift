//
//  UnderLinedButton.swift
//  NewsHabit
//
//  Created by 지연 on 3/2/25.
//

import UIKit

final class UnderLinedButton: UIButton {
    // MARK: - Init
    
    init(
        title: String,
        font: UIFont = .medium(size: 12),
        titleColor: UIColor = .labelAssistive
    ) {
        super.init(frame: .zero)
        setupButton(title: title, font: font, titleColor: titleColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupButton(title: String, font: UIFont, titleColor: UIColor) {
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: [
                .font: font,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        setAttributedTitle(attributedTitle, for: .normal)
        setTitleColor(titleColor, for: .normal)
    }
}
