//
//  NotificationView.swift
//  NewsHabit
//
//  Created by 지연 on 3/11/25.
//

import UIKit

final class NotificationView: UIView {
    // MARK: - Components
    
    private let containerView = UIView()
    
    private let notificationLabel = {
        let label = UILabel()
        label.text = "알림"
        label.font = .regular(size: 16)
        label.textColor = .labelNormal
        return label
    }()
    
    let switchControl = {
        let view = UISwitch()
        view.onTintColor = .primaryNormal
        view.transform = .init(scaleX: 0.8, y: 0.8)
        return view
    }()
    
    let notificationTimeButton = NotificationTimeButton()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        containerView.addSubview(notificationLabel)
        notificationLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        containerView.addSubview(switchControl)
        switchControl.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        addSubview(notificationTimeButton)
        notificationTimeButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
    }
}
