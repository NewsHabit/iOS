//
//  SettingsView.swift
//  NewsHabit
//
//  Created by 지연 on 3/9/25.
//

import UIKit

final class SettingsView: UIView {
    // MARK: - Components
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "설정"
        label.font = .bold(size: 24)
        label.textColor = .labelNormal
        label.setLineHeight(34)
        return label
    }()
    
    private lazy var userStackView = makeStackView()
    
    let nameButton = SettingsButton(type: .description)
    
    let categoryButton = SettingsButton(type: .description)
    
    let dailyGoalButton = SettingsButton(type: .description)
    
    let notificationButton = SettingsButton(type: .description)
    
    private lazy var accountStackView = makeStackView()
    
    let contactButton = SettingsButton(type: .chevron)
    
    let logoutButton = SettingsButton(type: .normal)
    
    let resetButton = SettingsButton(type: .normal)
    
    let deleteAccountButton = SettingsButton(type: .normal, isDimmed: true)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        configureImmutableButtons()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(userStackView)
        userStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview()
        }
        
        [nameButton, categoryButton, dailyGoalButton, notificationButton, contactButton].forEach {
            userStackView.addArrangedSubview($0)
            $0.snp.makeConstraints { make in
                make.height.equalTo(44)
            }
        }
        
        addSubview(accountStackView)
        accountStackView.snp.makeConstraints { make in
            make.top.equalTo(userStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        
        [logoutButton, resetButton, deleteAccountButton].forEach {
            accountStackView.addArrangedSubview($0)
            $0.snp.makeConstraints { make in
                make.height.equalTo(44)
            }
        }
    }
    
    // MARK: - Configure Methods
    
    private func configureImmutableButtons() {
        contactButton.configure(with: "문의하기")
        logoutButton.configure(with: "로그아웃")
        resetButton.configure(with: "데이터 초기화")
        deleteAccountButton.configure(with: "계정 삭제")
    }
    
    func configure(with model: SettingsModel) {
        nameButton.configure(with: "이름", description: model.name)
        categoryButton.configure(with: "관심 카테고리", description: model.category)
        dailyGoalButton.configure(with: "읽기 목표", description: model.dailyGoal)
        notificationButton.configure(with: "알림", description: model.notification)
    }
}

private extension SettingsView {
    func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }
}
