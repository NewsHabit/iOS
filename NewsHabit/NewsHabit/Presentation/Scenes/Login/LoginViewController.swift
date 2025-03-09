//
//  LoginViewController.swift
//  NewsHabit
//
//  Created by 지연 on 3/1/25.
//

import Combine
import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func loginDidFinish()
}

final class LoginViewController: BaseViewController<LoginView> {
    weak var delegate: LoginViewControllerDelegate?
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
                self?.delegate?.loginDidFinish()
            }
            .store(in: &cancellables)
        
        googleLoginButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.loginDidFinish()
            }
            .store(in: &cancellables)
        
        kakaoLoginButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.loginDidFinish()
            }
            .store(in: &cancellables)
        
        skipButton.tapPublisher
            .sink { [weak self] in
                self?.showAlert(.alert(
                    title: "로그인 오류",
                    message: "잠시 후 다시 시도해 주세요",
                    actionText: "확인"
                ))
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
    
    var skipButton: UIButton {
        contentView.skipButton
    }
}
