//
//  LineTextField.swift
//  NewsHabit
//
//  Created by 지연 on 3/2/25.
//

import UIKit

enum LineTextFieldStatus {
    case normal
    case focus
    case error
}

final class LineTextField: UIView {
    // MARK: - Components
    
    private let textField = {
        let textField = UITextField()
        textField.font = .semibold(size: 16)
        textField.textColor = .labelNormal
        textField.clearButtonMode = .always
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let line = {
        let view = UIView()
        view.backgroundColor = .lineNormal
        return view
    }()
    
    // MARK: - Init
    
    init(placeholder: String? = nil) {
        super.init(frame: .zero)
        setupTextField(with: placeholder)
        setupLayout()
        setupAction()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupTextField(with placeholder: String?) {
        textField.placeholder = placeholder
    }
    
    private func setupLayout() {
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
            make.height.equalTo(24)
        }
        
        addSubview(line)
        line.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
    }
    
    private func setupAction() {
        textField.addTarget(
            self,
            action: #selector(handleTextFieldEditingDidBegin),
            for: .editingDidBegin
        )
        textField.addTarget(
            self,
            action: #selector(handleTextFieldEditingDidEnd),
            for: .editingDidEnd
        )
    }
    
    // MARK: - Action Methods
    
    @objc private func handleTextFieldEditingDidBegin() {
        setStatus(.focus)
    }
    
    @objc private func handleTextFieldEditingDidEnd() {
        setStatus(.normal)
    }
    
    // MARK: - Configure Methods
    
    func setStatus(_ status: LineTextFieldStatus) {
        switch status {
        case .normal:
            line.backgroundColor = .lineNormal
        case .focus:
            line.backgroundColor = .primaryNormal
        case .error:
            line.backgroundColor = .point
        }
    }
}
