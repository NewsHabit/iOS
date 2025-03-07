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
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        keyboardShowPublisher.sink { [weak self] keyboardHeight in
            self?.contentView.updateNextButtonBottomConstraint(keyboardHeight)
        }.store(in: &cancellables)
        
        keyboardHidePublisher.sink { [weak self] in
            self?.contentView.updateNextButtonBottomConstraint()
        }.store(in: &cancellables)
    }
}
