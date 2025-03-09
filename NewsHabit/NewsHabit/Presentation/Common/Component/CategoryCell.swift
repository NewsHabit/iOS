//
//  CategoryCell.swift
//  NewsHabit
//
//  Created by 지연 on 3/7/25.
//

import UIKit

final class CategoryCell: UICollectionViewCell, Reusable {
    private let plusImage: UIImage = .plus
    private let checkImage: UIImage = .checkBoxActive
    
    // MARK: - Components
    
    private let nameLabel = {
        let label = UILabel()
        label.font = .semibold(size: 15)
        return label
    }()
    
    private let statusImageView = {
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
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(statusImageView)
        statusImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.trailing.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Configure Methods
    
    func configure(with model: CategoryModel) {
        nameLabel.text = model.name
        nameLabel.textColor = model.isSelected ? .primaryStrong : .labelDisabled
        statusImageView.image = model.isSelected ? checkImage : plusImage
        backgroundColor = model.isSelected ? .primaryLight : .background
        layer.borderColor = (model.isSelected ? UIColor.clear : UIColor.lineLight).cgColor
    }
}
