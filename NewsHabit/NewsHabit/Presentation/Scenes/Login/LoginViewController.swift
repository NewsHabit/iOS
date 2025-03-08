//
//  LoginViewController.swift
//  NewsHabit
//
//  Created by 지연 on 3/1/25.
//

import Combine
import UIKit

final class LoginViewController: BaseViewController<LoginView> {
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        appleLoginButton.tapPublisher
            .sink { [weak self] in
                self?.navigate(to: NameViewController(), animated: false)
            }
            .store(in: &cancellables)
        
        googleLoginButton.tapPublisher
            .sink { [weak self] in
                self?.navigate(to: NameViewController(), animated: false)
            }
            .store(in: &cancellables)
        
        kakaoLoginButton.tapPublisher
            .sink { [weak self] in
                self?.navigate(to: NameViewController(), animated: false)
            }
            .store(in: &cancellables)
    }
}

private extension LoginViewController {
    var appleLoginButton: UIButton {
        contentView.appleLoginButton
    }
    
    var googleLoginButton: UIButton {
        contentView.googleLoginButton
    }
    
    var kakaoLoginButton: UIButton {
        contentView.kakaoLoginButton
    }
}
