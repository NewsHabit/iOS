//
//  SplashView.swift
//  NewsHabit
//
//  Created by 지연 on 3/1/25.
//

import UIKit

final class SplashView: UIView {
    // MARK: - Components
    
    private let logoImageView = {
        let imageView = UIImageView()
        imageView.image = .logo
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        backgroundColor = .background
    }
    
    private func setupLayout() {
        addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(3)
            make.center.equalToSuperview()
        }
    }
}
