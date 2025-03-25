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
        if model.isToday {
            dayLabel.font = .semibold(size: 13)
            dayLabel.textColor = .primaryStrong
            layer.borderColor = UIColor.primaryAssistive.cgColor
            backgroundColor = .primaryLight
        } else if model.isRead {
            dayLabel.font = .semibold(size: 13)
            dayLabel.textColor = .white
            layer.borderColor = UIColor.primaryNormal.cgColor
            backgroundColor = .primaryNormal
        } else {
            dayLabel.font = .medium(size: 13)
            dayLabel.textColor = .labelDisabled
            layer.borderColor = UIColor.fillAssistive.cgColor
            backgroundColor = .fillAssistive
        }
    }
}
