//
//  DailyGoalCell.swift
//  NewsHabit
//
//  Created by 지연 on 3/9/25.
//

import UIKit

final class DailyGoalCell: UICollectionViewCell, Reusable {
    private let activeImage: UIImage = .checkBoxActive
    private let inactiveImage: UIImage = .checkBox
    
    // MARK: - Components
    
    private let descriptionLabel = {
        let label = UILabel()
        label.font = .medium(size: 13)
        label.textColor = .labelAssistive
        return label
    }()
    
    private let countLabel = {
        let label = UILabel()
        label.font = .semibold(size: 16)
        return label
    }()
    
    private let checkImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupCell() {
        backgroundColor = .clear
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.clear.cgColor
    }
    
    private func setupLayout() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.leading.equalToSuperview().inset(18)
        }
        
        contentView.addSubview(countLabel)
        countLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(14)
            make.leading.equalToSuperview().inset(18)
        }
        
        contentView.addSubview(checkImageView)
        checkImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.trailing.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Configure Methods
    
    func configure(with model: DailyGoalModel) {
        descriptionLabel.text = model.description
        descriptionLabel.setLineHeight(20)
        countLabel.text = model.count
        countLabel.setLineHeight(24)
        countLabel.textColor = model.isSelected ? .primaryStrong : .labelDisabled
        checkImageView.image = model.isSelected ? activeImage : inactiveImage
        backgroundColor = model.isSelected ? .primaryLight : .background
        layer.borderColor = (model.isSelected ? UIColor.clear : UIColor.lineLight).cgColor
    }
}
