//
//  NotificationViewController.swift
//  NewsHabit
//
//  Created by 지연 on 3/11/25.
//

import Combine
import UIKit

protocol NotificationViewControllerDelegate: AnyObject {
    func notificationDidFinish()
    func presentNotificationTime()
}

final class NotificationViewController: BaseViewController<NotificationView> {
    weak var delegate: NotificationViewControllerDelegate?
    private let viewModel: NotificationViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: NotificationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(with: .back("알림"))
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        // action
        backButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.notificationDidFinish()
            }
            .store(in: &cancellables)
        
        switchControl.isOnPublisher
            .removeDuplicates()
            .sink { [weak self] isOn in
                self?.viewModel.send(.switchDidToggle(isOn: isOn))
            }
            .store(in: &cancellables)
        
        notificationTimeButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.presentNotificationTime()
            }
            .store(in: &cancellables)
        
        // state
        viewModel.state.isNotificationOn
            .sink { [weak self] isOn in
                guard let self = self else { return }
                switchControl.isOn = isOn
                notificationTimeButton.isEnabled = isOn
            }
            .store(in: &cancellables)
        
        viewModel.state.notificationTime
            .sink { [weak self] time in
                self?.notificationTimeButton.configure(with: time)
            }
            .store(in: &cancellables)
    }
}

private extension NotificationViewController {
    var switchControl: UISwitch {
        contentView.switchControl
    }
    
    var notificationTimeButton: NotificationTimeButton {
        contentView.notificationTimeButton
    }
}
