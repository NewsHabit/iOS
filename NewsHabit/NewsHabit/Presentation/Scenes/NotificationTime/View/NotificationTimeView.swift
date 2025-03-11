//
//  NotificationTimeView.swift
//  NewsHabit
//
//  Created by 지연 on 3/12/25.
//

import UIKit

final class NotificationTimeView: UIView {
    // MARK: - Components
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "알림 시간 선택"
        label.font = .bold(size: 18)
        label.textColor = .labelNeutral
        return label
    }()
    
    private lazy var meridiemLabel = makeLabel(with: "오전/오후 선택")
    
    let meridiemSelectionView = MeridiemSelectionView()
    
    private lazy var hourLabel = makeLabel(with: "시간 선택")
    
    let hourSelectionView = HourSelectionView()
    
    private lazy var minuteLabel = makeLabel(with: "분 선택")
    
    let minuteSelectionView = MinuteSelectionView()
    
    let doneButton = ConfirmButton(title: "선택 완료")
    
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
            make.top.equalToSuperview().inset(30)
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(meridiemLabel)
        meridiemLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(meridiemSelectionView)
        meridiemSelectionView.snp.makeConstraints { make in
            make.top.equalTo(meridiemLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        addSubview(hourLabel)
        hourLabel.snp.makeConstraints { make in
            make.top.equalTo(meridiemSelectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(hourSelectionView)
        hourSelectionView.snp.makeConstraints { make in
            make.top.equalTo(hourLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        addSubview(minuteLabel)
        minuteLabel.snp.makeConstraints { make in
            make.top.equalTo(hourSelectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(minuteSelectionView)
        minuteSelectionView.snp.makeConstraints { make in
            make.top.equalTo(minuteLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(34)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
    }
}

private extension NotificationTimeView {
    func makeLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .medium(size: 13)
        label.textColor = .labelAssistive
        return label
    }
}
