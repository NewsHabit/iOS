//
//  CategoryFilterView.swift
//  NewsHabit
//
//  Created by 지연 on 3/25/25.
//

import UIKit

final class CategoryFilterView: UIView {
    // MARK: - Components
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "카테고리 선택"
        label.font = .bold(size: 18)
        label.textColor = .labelNeutral
        return label
    }()
    
    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerCell(cellType: CategoryFilterCell.self)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let applyButton = ConfirmButton(title: "적용하기")
    
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
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(36)
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(applyButton)
        applyButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(34)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.bottom.equalTo(applyButton.snp.top).offset(-30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
