//
//  LoginView.swift
//  NewsHabit
//
//  Created by 지연 on 3/1/25.
//

import UIKit

final class LoginView: UIView {
    // MARK: - Components
    
    private let logoView = LogoView()
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    let appleLoginButton = LoginButton(type: .apple)
    
    let googleLoginButton = LoginButton(type: .google)
    
    let kakaoLoginButton = LoginButton(type: .kakao)
    
    let skipButton = UnderLinedButton(title: "회원가입은 나중에! 둘러볼게요")
    
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
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(100)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        [appleLoginButton, googleLoginButton, kakaoLoginButton].forEach {
            stackView.addArrangedSubview($0)
            $0.snp.makeConstraints { make in
                make.height.equalTo(52)
            }
        }
        
        addSubview(logoView)
        logoView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(stackView.snp.top)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        addSubview(skipButton)
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
}
