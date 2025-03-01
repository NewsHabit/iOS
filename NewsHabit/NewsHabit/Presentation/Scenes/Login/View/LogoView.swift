//
//  LogoView.swift
//  NewsHabit
//
//  Created by 지연 on 3/1/25.
//

import UIKit

final class LogoView: UIView {
    // MARK: - Components
    
    private let blurLogoImageView = {
        let imageView = UIImageView()
        imageView.image = .blurLogo
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private let newsHabitLabel = {
        let label = UILabel()
        label.text = "NewsHabit"
        label.font = .logo(size: 45)
        label.textColor = .labelNeutral
        label.textAlignment = .center
        return label
    }()
    
    private let subTitleLabel = {
        let label = UILabel()
        label.text = "뉴스를 습관처럼"
        label.font = .semibold(size: 16)
        label.textColor = .labelNeutral
        label.textAlignment = .center
        return label
    }()
    
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
        addSubview(blurLogoImageView)
        blurLogoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(50)
        }
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        stackView.addArrangedSubview(newsHabitLabel)
        stackView.addArrangedSubview(subTitleLabel)
    }
}
