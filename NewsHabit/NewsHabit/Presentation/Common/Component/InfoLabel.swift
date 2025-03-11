//
//  InfoLabel.swift
//  NewsHabit
//
//  Created by 지연 on 3/2/25.
//

import UIKit

final class InfoLabel: UIView {
    // MARK: - Components
    
    private let infoImageView = {
        let imageView = UIImageView()
        imageView.image = .info.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .labelAssistive
        return imageView
    }()
    
    private let label = {
        let label = UILabel()
        label.font = .medium(size: 14)
        label.textColor = .labelAssistive
        return label
    }()
    
    // MARK: - Init
    
    init(_ text: String) {
        super.init(frame: .zero)
        setupLabel(with: text)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLabel(with text: String) {
        label.text = text
        label.setLineHeight(20)
    }
    
    private func setupLayout() {
        addSubview(infoImageView)
        infoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(18)
            make.top.leading.bottom.equalToSuperview()
        }
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalTo(infoImageView.snp.trailing).offset(3)
            make.trailing.centerY.equalToSuperview()
        }
    }
}
