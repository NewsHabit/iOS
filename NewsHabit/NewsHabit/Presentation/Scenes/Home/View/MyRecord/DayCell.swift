//
//  DayCell.swift
//  NewsHabit
//
//  Created by 지연 on 3/25/25.
//

import UIKit

final class DayCell: UICollectionViewCell, Reusable {
    // MARK: - Components
    
    private let dayLabel = UILabel()
    
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
        layer.cornerRadius = 5
        layer.borderWidth = 2
    }
    
    private func setupLayout() {
        contentView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - Configure Methods
    
    func configure(with model: DayCellModel) {
        dayLabel.text = model.day
        switch model.type {
        case .empty:
            layer.borderColor = UIColor.white.cgColor
            backgroundColor = .white
        case .today:
            dayLabel.font = .semibold(size: 13)
            dayLabel.textColor = .primaryStrong
            layer.borderColor = UIColor.primaryAssistive.cgColor
            backgroundColor = .primaryLight
        case .read:
            dayLabel.font = .semibold(size: 13)
            dayLabel.textColor = .white
            layer.borderColor = UIColor.primaryNormal.cgColor
            backgroundColor = .primaryNormal
        case .unread:
            dayLabel.font = .medium(size: 13)
            dayLabel.textColor = .labelDisabled
            layer.borderColor = UIColor.fillAssistive.cgColor
            backgroundColor = .fillAssistive
        }
    }
}
