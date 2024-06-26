//
//  CategoryCell.swift
//  NewsHabit
//
//  Created by jiyeon on 2/14/24.
//

import UIKit

import SnapKit
import Then

final class CategoryCell: UICollectionViewCell, BaseViewProtocol {
    
    static let reuseIdentifier = "CategoryCell"
    
    // MARK: - UI Components
    
    private let label = UILabel().then {
        $0.font = .caption
        $0.textColor = .systemBackground
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - BaseViewProtocol
    
    func setupProperty() {
        clipsToBounds = true
        layer.cornerRadius = 13
    }
    
    func setupHierarchy() {
        contentView.addSubview(label)
    }
    
    func setupLayout() {
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func configure(with category: String) {
        label.text = category
    }
    
    func setSelected(_ isSelected: Bool) {
        backgroundColor = isSelected ? .label : .newsHabitLightGray
    }
    
}
