//
//  DailyGoalView.swift
//  NewsHabit
//
//  Created by 지연 on 3/9/25.
//

import UIKit

final class DailyGoalView: UIView {
    // MARK: - Components
    
    private let stepBar = OnboardingStepBar(step: .dailyGoal)
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "하루에 읽을 기사 개수를\n선택해주세요"
        label.font = .bold(size: 24)
        label.setLineHeight(34)
        label.textColor = .labelNormal
        label.numberOfLines = 2
        return label
    }()
    
    private let infoLabel = {
        let label = UILabel()
        label.text = "매일 조금씩 읽는 습관을 만들어 가요"
        label.font = .medium(size: 14)
        label.textColor = .labelAssistive
        return label
    }()
    
    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerCell(cellType: DailyGoalCell.self)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let startButton = ConfirmButton(title: "시작하기")
    
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
        addSubview(stepBar)
        stepBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(6)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(stepBar.snp.bottom).offset(28)
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(34)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
    }
}
