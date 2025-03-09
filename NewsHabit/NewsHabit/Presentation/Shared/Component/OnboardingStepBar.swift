//
//  OnboardingStepBar.swift
//  NewsHabit
//
//  Created by 지연 on 3/2/25.
//

import UIKit
import SnapKit

enum OnboardingStep: CaseIterable {
    case name
    case category
    case dailyGoal
    
    var value: Int {
        switch self {
        case .name:         1
        case .category:     2
        case .dailyGoal:    3
        }
    }
}

final class OnboardingStepBar: UIView {
    private var widthConstraint: Constraint?
    
    // MARK: - Components
    
    private let stepView = {
        let view = UIView()
        view.backgroundColor = .primaryNormal
        return view
    }()
    
    // MARK: - Init
    
    init(step: OnboardingStep) {
        super.init(frame: .zero)
        setupView()
        setupLayout(with: step.value)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stepView.layer.cornerRadius = frame.height / 2
        layer.cornerRadius = frame.height / 2
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        backgroundColor = .primaryLight
    }
    
    private func setupLayout(with step: Int) {
        addSubview(stepView)
        
        let totalCount = CGFloat(OnboardingStep.allCases.count)
        
        let initialWidthMultiplier = CGFloat(step - 1) / totalCount
        stepView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(initialWidthMultiplier)
        }
        
        let targetWidthMultiplier = CGFloat(step) / totalCount
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: 0.5) {
                self.stepView.snp.remakeConstraints { make in
                    make.top.leading.bottom.equalToSuperview()
                    make.width.equalToSuperview().multipliedBy(targetWidthMultiplier)
                }
                self.layoutIfNeeded()
            }
        }
    }
}
