//
//  MainCoordinator.swift
//  NewsHabit
//
//  Created by 지연 on 3/9/25.
//

import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func mainDidFinish(_ coordinator: MainCoordinator)
}

final class MainCoordinator: Coordinator {
    weak var delegate: MainCoordinatorDelegate?
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showTabBarController()
    }
    
    private func showTabBarController() {
        let viewController = TabBarController()
        
        viewController.setViewControllers([
            makeViewController(
                from: makeHomeViewController(),
                image: .home,
                selectedImage: .homeFill
            ),
            makeViewController(
                from: makeTrendingViewController(),
                image: .news,
                selectedImage: .newsFill
            ),
            makeViewController(
                from: makeSettingsViewController(),
                image: .settings,
                selectedImage: .settingsFill
            )
        ],animated: false)
        
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func makeViewController(
        from viewController: UIViewController,
        image: UIImage,
        selectedImage: UIImage
    ) -> UIViewController {
        let tabBarItem = UITabBarItem(title: nil, image: image, selectedImage: selectedImage)
        viewController.tabBarItem = tabBarItem
        return viewController
    }
    
    private func makeHomeViewController() -> HomeViewController {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        viewController.delegate = self
        return viewController
    }
    
    private func makeTrendingViewController() -> TrendingViewController {
        let viewModel = TrendingViewModel()
        let viewController = TrendingViewController(viewModel: viewModel)
        return viewController
    }
    
    private func makeSettingsViewController() -> SettingsViewController {
        let viewController = SettingsViewController()
        viewController.delegate = self
        return viewController
    }
    
    private func showCategoryFilterViewController() {
        let viewModel = CategoryFilterViewModel()
        let viewController = CategoryFilterViewController(viewModel: viewModel)
        navigationController.present(viewController, animated: false)
    }
    
    private func showNameViewController() {
        let viewController = NameViewController(for: .settings)
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showCategoryViewController() {
        let viewModel = CategoryViewModel()
        let viewController = CategoryViewController(viewModel: viewModel, for: .settings)
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showDailyGoalViewController() {
        let viewModel = DailyGoalViewModel()
        let viewController = DailyGoalViewController(viewModel: viewModel, for: .settings)
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showNotificationViewController() {
        let viewModel = NotificationViewModel()
        let viewController = NotificationViewController(viewModel: viewModel)
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showNotificationTimeViewController(
        time: String,
        delegate: NotificationTimeViewControllerDelegate
    ) {
        let viewModel = NotificationTimeViewModel(time: time)
        let viewController = NotificationTimeViewController(viewModel: viewModel)
        viewController.delegate = delegate
        navigationController.present(viewController, animated: false)
    }
}

extension MainCoordinator: HomeViewControllerDelegate {
    func presentCategoryFilter() {
        showCategoryFilterViewController()
    }
}

extension MainCoordinator: SettingsViewControllerDelegate {
    func navigateToName() {
        showNameViewController()
    }
    
    func navigateToCategory() {
        showCategoryViewController()
    }
    
    func navigateToDailyGoal() {
        showDailyGoalViewController()
    }
    
    func navigateToNotification() {
        showNotificationViewController()
    }
}

extension MainCoordinator: NameViewControllerDelegate {
    func nameDidFinish() {
        navigationController.popViewController(animated: true)
    }
}

extension MainCoordinator: CategoryViewControllerDelegate {
    func categoryDidFinish() {
        navigationController.popViewController(animated: true)
    }
}

extension MainCoordinator: DailyGoalViewControllerDelegate {
    func dailyGoalDidFinish() {
        navigationController.popViewController(animated: true)
    }
}

extension MainCoordinator: NotificationViewControllerDelegate {
    func notificationDidFinish() {
        navigationController.popViewController(animated: true)
    }
    
    func presentNotificationTime(time: String, delegate: NotificationTimeViewControllerDelegate) {
        showNotificationTimeViewController(time: time, delegate: delegate)
    }
}
