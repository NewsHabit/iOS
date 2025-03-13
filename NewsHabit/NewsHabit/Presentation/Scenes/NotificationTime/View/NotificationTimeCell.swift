//
//  NotificationTimeCell.swift
//  NewsHabit
//
//  Created by 지연 on 3/12/25.
//

import UIKit

final class NotificationTimeCell: UICollectionViewCell, Reusable {
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    // MARK: - Components
    
    private let label = UILabel()
    
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
        layer.cornerRadius = 8
        layer.borderWidth = 1
        updateAppearance()
    }
    
    private func setupLayout() {
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func updateAppearance() {
        label.textColor = isSelected ? .primaryStrong : .labelDisabled
        label.font = isSelected ? .semibold(size: 13) : .medium(size: 13)
        backgroundColor = isSelected ? .primaryLight : .white
        layer.borderColor = isSelected ? UIColor.primaryLight.cgColor : UIColor.lineLight.cgColor
    }
    
    // MARK: - Configure Methods
    
    func configure(with text: String) {
        label.text = text
    }
}
