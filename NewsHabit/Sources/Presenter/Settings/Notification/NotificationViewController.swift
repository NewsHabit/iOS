//
//  NotificationViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import UIKit

final class NotificationViewController: BaseViewController<NotificationView>, BaseViewControllerProtocol {
    
    private let viewModel = NotificationViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupNotificationCenterObserver()
        contentView.delegate = self
        contentView.bind(with: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        setNavigationBarShareButtonHidden(true)
        setNavigationBarTitle("알림")
    }
    
    private func setupNotificationCenterObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotificationAuthorizationDidUpate),
            name: .NotificationAuthorizationDidUpdate,
            object: nil
        )
    }
    
    @objc private func handleNotificationAuthorizationDidUpate() {
        contentView.updateNotificationStatus()
    }
    
}

extension NotificationViewController: NotificationViewDelegate {
    
    func showNotificationPermissionAlert() {
        let alertController = UIAlertController(
            title: "'뉴빗'에서 알림 권한을 사용하려고 합니다.",
            message: "알림을 통해 추천 뉴스를 바로 받아보세요. 설정에서 언제든지 이를 변경할 수 있습니다.",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let navigateAction = UIAlertAction(
            title: "설정으로 이동",
            style: .default,
            handler: openAppSettings
        )
        
        alertController.addAction(cancelAction)
        alertController.addAction(navigateAction)
        
        present(alertController, animated: true)
    }
    
    private func openAppSettings(_ sender: UIAlertAction) {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
    
}
