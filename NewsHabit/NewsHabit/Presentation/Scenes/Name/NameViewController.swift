//
//  NameViewController.swift
//  NewsHabit
//
//  Created by 지연 on 3/2/25.
//

import Combine
import UIKit

final class NameViewController: BaseViewController<NameView> {
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionBindings()
        textField.becomeFirstResponder()
    }
    
    // MARK: - Setup Methods
    
    private func setupActionBindings() {
        keyboardShowPublisher.sink { [weak self] keyboardHeight in
            self?.contentView.updateNextButtonBottomConstraint(keyboardHeight)
        }.store(in: &cancellables)
        
        keyboardHidePublisher.sink { [weak self] in
            self?.contentView.updateNextButtonBottomConstraint()
        }.store(in: &cancellables)
        
        nextButton.tapPublisher.sink { [weak self] in
            self?.navigate(to: CategoryViewController(), animated: false)
        }.store(in: &cancellables)
    }
}

private extension NameViewController {
    var textField: LineTextField {
        contentView.textField
    }
    
    var nextButton: UIButton {
        contentView.nextButton
    }
}
