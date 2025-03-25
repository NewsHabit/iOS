//
//  CategoryFilterButton.swift
//  NewsHabit
//
//  Created by 지연 on 3/25/25.
//

import UIKit

final class CategoryFilterButton: UIButton {
    // MARK: - Components
    
    private let categoryLabel = {
        let label = UILabel()
        label.font = .semibold(size: 11)
        label.textColor = .labelAssistive
        return label
    }()
    
    private let chevronDownImageView = {
        let imageView = UIImageView()
        imageView.image = .chevronDown
        imageView.contentMode = .scaleAspectFit
        return imageView
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
    
    // MARK: - Setup Methods
    
    private func setupButton() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.lineNormal.cgColor
    }
    
    private func setupLayout() {
        addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(3)
        }
        
        addSubview(chevronDownImageView)
        chevronDownImageView.snp.makeConstraints { make in
            make.width.height.equalTo(12)
            make.leading.equalTo(categoryLabel.snp.trailing).offset(3)
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Configure Methods
    
    func updateCategory(with category: String) {
        categoryLabel.text = category
    }
}
