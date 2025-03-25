//
//  CategoryFilterCell.swift
//  NewsHabit
//
//  Created by 지연 on 3/25/25.
//

import UIKit

final class CategoryFilterCell: UICollectionViewCell, Reusable {
    private let activeImage = UIImage.checkBoxActive
    private let inactiveImage = UIImage.checkBox
    
    // MARK: - Components
    
    private let checkImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let filterNameLabel = {
        let label = UILabel()
        label.font = .medium(size: 16)
        label.textColor = .labelNormal
        return label
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
    }
    
    private func setupLayout() {
        contentView.addSubview(checkImageView)
        checkImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.leading.centerY.equalToSuperview()
        }
        
        contentView.addSubview(filterNameLabel)
        filterNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkImageView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Configure Methods
    
    func configure(with model: CategoryFilterCellModel) {
        filterNameLabel.text = model.filterName
        checkImageView.image = model.isSelected ? activeImage : inactiveImage
    }
}
