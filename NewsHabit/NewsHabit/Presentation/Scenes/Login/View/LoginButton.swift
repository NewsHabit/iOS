//
//  LoginButton.swift
//  NewsHabit
//
//  Created by 지연 on 3/2/25.
//

import UIKit

extension SocialType {
    var name: String {
        switch self {
        case .apple:    "Apple"
        case .google:   "Google"
        case .kakao:    "Kakao"
        }
    }
    
    var foregroundColor: UIColor {
        switch self {
        case .apple:    .white
        case .google:   .black
        case .kakao:    .kakaoForeground
                
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .apple:    .black
        case .google:   .white
        case .kakao:    .kakaoBackground
        }
    }
}

final class LoginButton: UIButton {
    // MARK: - Components
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
    
    private let iconImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label = {
        let label = UILabel()
        label.font = .semibold(size: 16)
        return label
    }()
    
    // MARK: - Init
    
    init(type: SocialType) {
        super.init(frame: .zero)
        setupButton(with: type)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupButton(with type: SocialType) {
        layer.cornerRadius = 8
        iconImageView.image = UIImage(named: type.name)
        label.text = "\(type.name)로 계속하기"
        label.textColor = type.foregroundColor
        backgroundColor = type.backgroundColor
        if type == .google {
            layer.borderWidth = 1
            layer.borderColor = UIColor.lineStrong.cgColor
        }
    }
    
    private func setupLayout() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        stackView.addArrangedSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(17)
        }
        
        stackView.addArrangedSubview(label)
    }
}
