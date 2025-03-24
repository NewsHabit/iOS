//
//  HomeTab.swift
//  NewsHabit
//
//  Created by 지연 on 3/20/25.
//

import Combine
import UIKit

final class HomeTab: UIView {
    var valuePublisher = PassthroughSubject<Int, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Components
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = .fillAssistive
        return view
    }()
    
    private let indicator: UIView = {
        let view = UIView()
        view.backgroundColor = .labelNormal
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupStackView()
        setupInitialStatus()
        setupBindings()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(24)
        }
        
        addSubview(line)
        line.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(2)
        }
        
        addSubview(indicator)
    }
    
    private func setupStackView() {
        HomeMenu.allCases.forEach { menu in
            let button = makeButton(with: menu.title)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func setupInitialStatus() {
        updateButtonColors(to: 0)
        
        guard let firstButton = stackView.arrangedSubviews.first as? UIButton else { return }
        indicator.snp.makeConstraints { make in
            make.leading.trailing.equalTo(firstButton)
            make.centerY.equalTo(line)
            make.height.equalTo(2)
        }
    }
    
    private func setupBindings() {
        stackView.arrangedSubviews
            .enumerated()
            .compactMap { (index, view) -> (Int, UIButton)? in
                guard let button = view as? UIButton else { return nil }
                return (index, button)
            }
            .forEach { (index, button) in
                button.tapPublisher
                    .sink { [weak self] in
                        self?.valuePublisher.send(index)
                        self?.updateIndicator(to: index)
                    }
                    .store(in: &cancellables)
            }
    }
    
    private func updateIndicator(to index: Int) {
        guard let button = stackView.arrangedSubviews[index] as? UIButton else { return }
        
        indicator.snp.remakeConstraints { make in
            make.leading.trailing.equalTo(button)
            make.centerY.equalTo(line)
            make.height.equalTo(2)
        }
        
        updateButtonColors(to: index)
        
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    private func updateButtonColors(to index: Int) {
        stackView.arrangedSubviews
            .enumerated()
            .forEach { (idx, view) in
                guard let button = view as? UIButton else { return }
                button.setTitleColor(idx == index ? .labelNormal : .labelDisabled, for: .normal)
            }
    }
}

private extension HomeTab {
    func makeButton(with text: String) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = .semibold(size: 16)
        button.setTitleColor(.labelNormal, for: .normal)
        return button
    }
}
