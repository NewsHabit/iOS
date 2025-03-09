//
//  SettingsButton.swift
//  NewsHabit
//
//  Created by 지연 on 3/9/25.
//

import UIKit

enum SettingsButtonType {
    case normal
    case chevron
    case description
}

final class SettingsButton: UIButton {
    // MARK: - Components
    
    private let label = {
        let label = UILabel()
        label.font = .regular(size: 16)
        label.textColor = .labelNormal
        return label
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.font = .medium(size: 14)
        label.textColor = .labelAssistive
        return label
    }()
    
    private let chevronImageView = {
        let imageView = UIImageView()
        imageView.image = .chevronRight.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .lineNormal
        return imageView
    }()
    
    // MARK: - Init
    
    init(type: SettingsButtonType) {
        super.init(frame: .zero)
        setupButton()
        setupLayout(with: type)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupButton() {
        setBackgroundImage(image(with: .background), for: .normal)
        setBackgroundImage(image(with: .fillAssistive), for: .highlighted)
    }
    
    private func setupLayout(with type: SettingsButtonType) {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        if type != .normal {
            addSubview(chevronImageView)
            chevronImageView.snp.makeConstraints { make in
                make.width.height.equalTo(12)
                make.trailing.equalToSuperview().inset(20)
                make.centerY.equalToSuperview()
            }
        }
        
        if type == .description {
            addSubview(descriptionLabel)
            descriptionLabel.snp.makeConstraints { make in
                make.trailing.equalTo(chevronImageView.snp.leading).offset(-8)
                make.centerY.equalToSuperview()
            }
        }
    }
    
    // MARK: - Configure Methods
    
    func configure(with title: String, description: String? = nil) {
        label.text = title
        descriptionLabel.text = description
    }
}
