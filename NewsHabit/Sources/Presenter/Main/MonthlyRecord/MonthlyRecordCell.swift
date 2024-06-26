//
//  MonthlyRecordCell.swift
//  NewsHabit
//
//  Created by jiyeon on 3/20/24.
//

import UIKit

import SnapKit
import Then

final class MonthlyRecordCell: UICollectionViewCell, BaseViewProtocol {
    
    static let reuseIdentifier = "MonthlyRecordCell"
    
    // MARK: - UI Components
    
    private let label = UILabel().then {
        $0.font = .footnote
        $0.textColor = .newsHabitLightGray
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
    
    override func prepareForReuse() {
        label.text = ""
        label.textColor = .newsHabitLightGray
        backgroundColor = .background
        layer.borderWidth = 0
    }
    
    // MARK: - BaseViewProtocol
    
    func setupProperty() {
        backgroundColor = .background
        clipsToBounds = true
        layer.cornerRadius = 10
    }
    
    func setupHierarchy() {
        addSubview(label)
    }
    
    func setupLayout() {
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    /// 날짜가 없는 빈 상태를 설정하는 함수
    func setAsEmptyDate() {
        backgroundColor = .background
    }
    
    /// 날짜의 읽음 여부와 오늘 날짜 여부를 설정하는 함수
    func configureDate(_ isRead: Bool, _ isToday: Bool, _ dayString: String) {
        label.text = dayString
        label.textColor = .newsHabitGray
        
        if isRead {
            backgroundColor = .newsHabit.withAlphaComponent(0.7)
        }
        
        if isToday {
            layer.borderWidth = 2
            layer.borderColor = UIColor.newsHabit.cgColor
        }
    }
    
}
