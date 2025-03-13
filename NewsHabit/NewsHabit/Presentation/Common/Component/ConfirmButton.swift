//
//  ConfirmButton.swift
//  NewsHabit
//
//  Created by 지연 on 3/2/25.
//

import UIKit

final class ConfirmButton: UIButton {
    // MARK: - Init
    
    init(title: String, font: UIFont = .semibold(size: 16)) {
        super.init(frame: .zero)
        setupButton(title: title, font: font)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupButton(title: String, font: UIFont) {
        // title
        let normalAttributedTitle = NSAttributedString(
            string: title,
            attributes: [
                .font: font,
                .foregroundColor: UIColor.white
            ]
        )
        setAttributedTitle(normalAttributedTitle, for: .normal)
        
        let disabledAttributedTitle = NSAttributedString(
            string: title,
            attributes: [
                .font: font,
                .foregroundColor: UIColor.labelDisabled
            ]
        )
        setAttributedTitle(disabledAttributedTitle, for: .disabled)
        // background
        clipsToBounds = true
        setBackgroundImage(image(with: .primaryNormal), for: .normal)
        setBackgroundImage(image(with: .primaryStrong), for: .highlighted)
        setBackgroundImage(image(with: .fillDisabled), for: .disabled)
        layer.cornerRadius = 8
    }
}
