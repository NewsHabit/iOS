//
//  SettingsViewController.swift
//  NewsHabit
//
//  Created by 지연 on 3/9/25.
//

import Combine
import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func navigateToName()
}

final class SettingsViewController: BaseViewController<SettingsView> {
    weak var delegate: SettingsViewControllerDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        // 임시
        contentView.configure(with: SettingsModel(
            name: "지연",
            category: "IT/과학",
            dailyGoal: "3개",
            notification: "OFF"
        ))
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        nameButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.navigateToName()
            }
            .store(in: &cancellables)
        
        logoutButton.tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                showAlert(.confirm(
                    title: "로그아웃",
                    message: "정말 로그아웃하시겠어요?",
                    cancelText: "취소",
                    actionText: "확인"
                )) {}
            }
            .store(in: &cancellables)
        
        resetButton.tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                showAlert(.warning(
                    title: "데이터 초기화",
                    message: "정말 모든 데이터를 초기화하시겠어요?\n완독 기록과 북마크가 삭제되며,\n복구할 수 없습니다",
                    cancelText: "취소",
                    actionText: "초기화하기"
                )) {}
            }
            .store(in: &cancellables)
        
        deleteAccountButton.tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                showAlert(.warning(
                    title: "계정 삭제",
                    message: "정말 계정을 삭제하시겠어요?\n모든 데이터가 영구적으로 삭제되며,\n복구할 수 없습니다",
                    cancelText: "취소",
                    actionText: "삭제하기"
                )) {}
            }
            .store(in: &cancellables)
    }
}

private extension SettingsViewController {
    var nameButton: UIButton {
        contentView.nameButton
    }
    
    var categoryButton: UIButton {
        contentView.categoryButton
    }
    
    var dailyGoalButton: UIButton {
        contentView.dailyGoalButton
    }
    
    var notificationButton: UIButton {
        contentView.notificationButton
    }
    
    var contanctButton: UIButton {
        contentView.contactButton
    }
    
    var logoutButton: UIButton {
        contentView.logoutButton
    }
    
    var resetButton: UIButton {
        contentView.resetButton
    }
    
    var deleteAccountButton: UIButton {
        contentView.deleteAccountButton
    }
}
