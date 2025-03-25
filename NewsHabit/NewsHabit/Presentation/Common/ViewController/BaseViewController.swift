//
//  BaseViewController.swift
//  NewsHabit
//
//  Created by 지연 on 3/1/25.
//

import UIKit
import SnapKit

enum NavigationBarStyle {
    case back(String)
    case backAndRefresh(String)
}

/// 커스텀 네비게이션 바를 구성할 수 있는 뷰 컨트롤러
class BaseViewController<View: UIView>: UIViewController {
    // MARK: - Components
    
    private let navigationBar = UIView()
    
    let contentView = View()
    
    private lazy var titleLabel = makeTitleLabel()
    
    lazy var backButton = makeButton(with: .chevronLeft)
    
    lazy var refreshButton = makeButton(with: .refresh)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupLayout()
        setupGestureRecognizer()
    }
    
    // MARK: - Setup Methods
    
    private func setupViewController() {
        view.backgroundColor = .background
    }
    
    // 커스텀 네비게이션 바를 사용하지 않는 초기 레이아웃
    private func setupLayout() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    private func setupBackButtonLayout() {
        navigationBar.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupRefreshButtonLayout() {
        navigationBar.addSubview(refreshButton)
        refreshButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleViewTap)
        )
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - Action Methods
    
    @objc private func handleViewTap() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.view.endEditing(true)
        }
    }
    
    // MARK: - Configure Methods
    
    func configureNavigationBar(with style: NavigationBarStyle) {
        switch style {
        case .back(let title):
            configureNavigationBar(title: title, isBackButtonEnabled: true)
        case .backAndRefresh(let title):
            configureNavigationBar(
                title: title,
                isBackButtonEnabled: true,
                isRefreshButtonEnabled: true
            )
        }
    }
    
    private func configureNavigationBar(
        title: String,
        isBackButtonEnabled: Bool = false,
        isRefreshButtonEnabled: Bool = false
    ) {
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        titleLabel.text = title
        navigationBar.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        if isBackButtonEnabled { setupBackButtonLayout() }
        if isRefreshButtonEnabled { setupRefreshButtonLayout() }
        contentView.snp.remakeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
}

private extension BaseViewController {
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .labelNormal
        label.font = .bold(size: 18)
        return label
    }
    
    func makeButton(with image: UIImage) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        return button
    }
}
