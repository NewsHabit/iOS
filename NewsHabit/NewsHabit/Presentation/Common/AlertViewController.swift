//
//  AlertViewController.swift
//  NewsHabit
//
//  Created by 지연 on 3/9/25.
//

import UIKit

enum AlertType {
    case alert(title: String, message: String?, actionText: String)
    case confirm(title: String, message: String?, cancelText: String, actionText: String)
}

final class AlertViewController: UIViewController {
    private var actionCompletion: (() -> Void)?
    
    // MARK: - Components
    
    private let containerView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let textStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.font = .semibold(size: 16)
        label.textColor = .labelNormal
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let messageLabel = {
        let label = UILabel()
        label.font = .regular(size: 14)
        label.textColor = .labelAssistive
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let buttonStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var cancelButton: UIButton?
    private var actionButton: UIButton?
    
    // MARK: - Init
    
    init(type: AlertType, actionCompletion: (() -> Void)?) {
        super.init(nibName: nil, bundle: nil)
        setupViewController()
        setupLayout()
        configure(with: type)
        self.actionCompletion = actionCompletion
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareForAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateIn()
    }
    
    // MARK: - Setup Methods
    
    private func setupViewController() {
        view.backgroundColor = .dim
        modalPresentationStyle = .overFullScreen
    }
    
    private func setupLayout() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.7)
            make.center.equalToSuperview()
        }
        
        containerView.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(52)
        }
        
        containerView.addSubview(textStackView)
        textStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(buttonStackView.snp.top).offset(-12)
        }
        
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(messageLabel)
    }
    
    private func configure(with type: AlertType) {
        switch type {
        case .alert(let title, let message, let actionText):
            configureAlert(title: title, message: message, actionText: actionText)
        case .confirm(let title, let message, let cancelText, let actionText):
            configureConfirm(
                title: title,
                message: message,
                cancelText: cancelText,
                actionText: actionText
            )
        }
    }
    
    private func configureAlert(title: String, message: String?, actionText: String) {
        titleLabel.text = title
        titleLabel.setLineHeight(24)
        messageLabel.text = message
        messageLabel.setLineHeight(20)
        // action button
        let actionButton = makeButton(
            with: .primaryStrong,
            maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        )
        actionButton.setTitle(actionText, for: .normal)
        actionButton.addTarget(
            self,
            action: #selector(handleActionButtonDidTap),
            for: .touchUpInside
        )
        buttonStackView.addArrangedSubview(actionButton)
        self.actionButton = actionButton
    }
    
    private func configureConfirm(
        title: String,
        message: String?,
        cancelText: String,
        actionText: String
    ) {
        titleLabel.text = title
        titleLabel.setLineHeight(24)
        messageLabel.text = message
        messageLabel.setLineHeight(20)
        // cancel button
        let cancelButton = makeButton(with: .labelDisabled, maskedCorners: [.layerMinXMaxYCorner])
        cancelButton.setTitle(cancelText, for: .normal)
        cancelButton.addTarget(
            self,
            action: #selector(handleCancelButtonDidTap),
            for: .touchUpInside
        )
        self.cancelButton = cancelButton
        buttonStackView.addArrangedSubview(cancelButton)
        // action button
        let actionButton = makeButton(with: .primaryStrong, maskedCorners: [.layerMaxXMaxYCorner])
        actionButton.setTitle(actionText, for: .normal)
        actionButton.addTarget(
            self,
            action: #selector(handleActionButtonDidTap),
            for: .touchUpInside
        )
        buttonStackView.addArrangedSubview(actionButton)
        self.actionButton = actionButton
    }
    
    // MARK: - Animation Methods
    
    func prepareForAnimation() {
        view.alpha = 0
        containerView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }
    
    func animateIn(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut) { [weak self] in
            self?.view.alpha = 1.0
            self?.containerView.transform = .identity
        } completion: { _ in
            completion?()
        }
    }
    
    func animateOut(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn) { [weak self] in
            self?.view.alpha = 0.0
        } completion: { _ in
            completion?()
        }
    }
    
    // MARK: - Action Methods
    
    @objc private func handleCancelButtonDidTap() {
        animateOut {
            self.dismiss(animated: false)
        }
    }
    
    @objc private func handleActionButtonDidTap() {
        animateOut {
            self.dismiss(animated: false, completion: self.actionCompletion)
        }
    }
}

private extension AlertViewController {
    func makeButton(with color: UIColor, maskedCorners: CACornerMask) -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = .medium(size: 16)
        button.setTitleColor(color, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.layer.maskedCorners = maskedCorners
        button.setBackgroundImage(image(with: .white), for: .normal)
        button.setBackgroundImage(image(with: .fillAssistive), for: .highlighted)
        return button
    }
    
    func image(with color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
