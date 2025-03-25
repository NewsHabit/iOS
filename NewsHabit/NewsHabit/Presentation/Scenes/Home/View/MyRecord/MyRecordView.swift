//
//  MyRecordView.swift
//  NewsHabit
//
//  Created by 지연 on 3/24/25.
//

import UIKit

final class MyRecordView: UIView {
    // MARK: - Components
    
    let yearMonthLabel = {
        let label = UILabel()
        label.font = .semibold(size: 16)
        label.textColor = .labelNeutral
        return label
    }()
    
    let prevButton = {
        let button = UIButton()
        let activeImage = UIImage.chevronLeft.withTintColor(.labelNormal)
        let inactiveImage = UIImage.chevronLeft.withTintColor(.labelDisabled)
        button.setImage(activeImage, for: .normal)
        button.setImage(inactiveImage, for: .disabled)
        return button
    }()
    
    let nextButton = {
        let button = UIButton()
        let activeImage = UIImage.chevronRight.withTintColor(.labelNormal)
        let inactiveImage = UIImage.chevronRight.withTintColor(.labelDisabled)
        button.setImage(activeImage, for: .normal)
        button.setImage(inactiveImage, for: .disabled)
        return button
    }()
    
    private let heartImageView = {
        let imageView = UIImageView()
        imageView.image = .heart
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let monthlyAllReadLabel = {
        let label = UILabel()
        label.font = .semibold(size: 16)
        label.textColor = .labelNormal
        return label
    }()
    
    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.registerCell(cellType: DayCell.self)
        return collectionView
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
        addSubview(yearMonthLabel)
        yearMonthLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
        
        addSubview(prevButton)
        prevButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalTo(yearMonthLabel)
            make.trailing.equalTo(yearMonthLabel.snp.leading).offset(-20)
        }
        
        addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalTo(yearMonthLabel)
            make.leading.equalTo(yearMonthLabel.snp.trailing).offset(20)
        }
        
        addSubview(monthlyAllReadLabel)
        monthlyAllReadLabel.snp.makeConstraints { make in
            make.top.equalTo(yearMonthLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(35)
        }
        
        addSubview(heartImageView)
        heartImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalTo(monthlyAllReadLabel)
            make.trailing.equalTo(monthlyAllReadLabel.snp.leading).offset(-2)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(monthlyAllReadLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(35)
            make.bottom.equalToSuperview()
        }
    }
}
