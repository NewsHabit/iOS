//
//  AllReadView.swift
//  NewsHabit
//
//  Created by 지연 on 3/24/25.
//

import UIKit

final class AllReadView: UIView {
    // MARK: - Components
    
    private let heartImageView = {
        let imageView = UIImageView()
        imageView.image = .heart
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let allReadLabel = UILabel()
    
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
        backgroundColor = .fillAssistive
        layer.cornerRadius = 12
    }
    
    private func setupLayout() {
        addSubview(heartImageView)
        heartImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.leading.equalToSuperview().inset(14)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        addSubview(allReadLabel)
        allReadLabel.snp.makeConstraints { make in
            make.leading.equalTo(heartImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(14)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Configure Methods
    
    func configure(with allReadCount: Int) {
        let allReadCountString = "\(allReadCount)일"
        allReadLabel.text = "습관 하루 적립! 지금까지 \(allReadCountString) 완독했어요"
        allReadLabel.font = .medium(size: 14)
        allReadLabel.textColor = .labelNeutral
        allReadLabel.setAttributedText(
            highlight: allReadCountString,
            color: .primaryStrong,
            font: .bold(size: 14)
        )
    }
}
