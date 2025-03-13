//
//  NameViewController.swift
//  NewsHabit
//
//  Created by 지연 on 3/2/25.
//

import Combine
import UIKit

protocol NameViewControllerDelegate: AnyObject {
    func nameDidFinish()
}

final class NameViewController: BaseViewController<NameView> {
    weak var delegate: NameViewControllerDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(for usage: ComponentUsage) {
        super.init(nibName: nil, bundle: nil)
        contentView.setupLayout(with: usage)
        if usage == .settings { configureNavigationBar(with: .back("이름")) }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        textField.becomeFirstResponder()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        backButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.nameDidFinish()
            }
            .store(in: &cancellables)
        
        keyboardShowPublisher
            .sink { [weak self] keyboardHeight in
                self?.contentView.updateNextButtonBottomConstraint(keyboardHeight)
            }
            .store(in: &cancellables)
        
        keyboardHidePublisher
            .sink { [weak self] in
                self?.contentView.updateNextButtonBottomConstraint()
            }
            .store(in: &cancellables)
        
        nextButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.nameDidFinish()
            }
            .store(in: &cancellables)
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
