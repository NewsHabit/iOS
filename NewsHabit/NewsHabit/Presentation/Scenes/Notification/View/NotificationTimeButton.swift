//
//  NotificationTimeButton.swift
//  NewsHabit
//
//  Created by 지연 on 3/11/25.
//

import UIKit

final class NotificationTimeButton: UIButton {
    override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    // MARK: - Components
    
    private let label = {
        let label = UILabel()
        label.text = "알림 시간"
        label.font = .regular(size: 16)
        label.textColor = .labelNormal
        return label
    }()
    
    private let timeLabel = {
        let label = UILabel()
        label.font = .medium(size: 14)
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        setupLayout()
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
    
    private func setupLayout() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    private func updateAppearance() {
        timeLabel.textColor = isEnabled ? .primaryStrong : .labelDisabled
    }
    
    // MARK: - Configure Methods
    
    func configure(with notificationTime: String) {
        timeLabel.text = notificationTime
    }
}
