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
    
    private let labelStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let guideLabel = {
        let label = UILabel()
        label.text = "매일 조금씩 읽는 습관을 만들어 가요"
        label.font = .medium(size: 14)
        label.setLineHeight(20)
        label.textColor = .labelAssistive
        return label
    }()
    
    private let infoLabel = InfoLabel("변경 사항은 저장 후 다음 날부터 적용됩니다")
    
    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerCell(cellType: DailyGoalCell.self)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    var ctaButton = ConfirmButton(title: "")
    
    // MARK: - Setup Methods
    
    func setupLayout(with usage: ComponentUsage) {
        switch usage {
        case .onboarding:
            ctaButton = ConfirmButton(title: "시작하기")
            
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
            
            addSubview(labelStackView)
            labelStackView.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(8)
                make.leading.trailing.equalToSuperview().inset(20)
            }
            
            labelStackView.addArrangedSubview(guideLabel)
        case .settings:
            ctaButton = ConfirmButton(title: "다음")
            
            addSubview(labelStackView)
            labelStackView.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview().inset(20)
            }
            
            labelStackView.addArrangedSubview(guideLabel)
            labelStackView.addArrangedSubview(infoLabel)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(labelStackView.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        addSubview(ctaButton)
        ctaButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(34)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
    }
}
