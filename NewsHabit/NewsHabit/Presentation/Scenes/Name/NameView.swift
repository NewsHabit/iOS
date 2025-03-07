//
//  NameView.swift
//  NewsHabit
//
//  Created by 지연 on 3/2/25.
//

import UIKit

final class NameView: UIView {
    // MARK: - Components
    
    private let stepBar = OnboardingStepBar(step: .name)
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "🙌🏻 뉴빗에 오신걸 환영해요!\n이름을 입력해주세요"
        label.font = .bold(size: 24)
        label.setLineHeight(34)
        label.textColor = .labelNormal
        label.numberOfLines = 2
        return label
    }()
    
    private let infoLabel = InfoLabel("8자 이내, 특수문자 사용 불가")
    
    let textField = LineTextField(placeholder: "이름")
    
    let nextButton = ConfirmButton(title: "다음")
    
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
        addSubview(stepBar)
        stepBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(6)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(stepBar.snp.bottom).offset(28)
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(34)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
    }
    
    // MARK: - Configure Methods
    
    func updateNextButtonBottomConstraint(_ keyboardHeight: CGFloat = 0) {
        nextButton.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().inset(keyboardHeight + 34)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        UIView.animate(withDuration: 0.35) {
            self.layoutIfNeeded()
        }
    }
}
