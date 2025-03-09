//
//  OnboardingCoordinator.swift
//  NewsHabit
//
//  Created by 지연 on 3/9/25.
//

import UIKit

protocol OnboardingCoordinatorDelegate: AnyObject {
    func onboardingDidFinish(_ coordinator: OnboardingCoordinator)
}

final class OnboardingCoordinator: Coordinator {
    weak var delegate: OnboardingCoordinatorDelegate?
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showLoginViewController()
    }
    
    // MARK: - Private Methods
    
    private func showLoginViewController() {
        let viewController = LoginViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func showNameViewController() {
        let viewController = NameViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func showCategoryViewController() {
        let viewModel = CategoryViewModel()
        let viewController = CategoryViewController(viewModel: viewModel)
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func showDailyGoalViewController() {
        let viewModel = DailyGoalViewModel()
        let viewController = DailyGoalViewController(viewModel: viewModel)
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension OnboardingCoordinator: LoginViewControllerDelegate {
    func loginDidFinish() {
        showNameViewController()
    }
}

extension OnboardingCoordinator: NameViewControllerDelegate {
    func nameDidFinish() {
        showCategoryViewController()
    }
}

extension OnboardingCoordinator: CategoryViewControllerDelegate {
    func categoryDidFinish() {
        showDailyGoalViewController()
    }
}

extension OnboardingCoordinator: DailyGoalViewControllerDelegate {
    func dailyGoalDidFinish() {
        delegate?.onboardingDidFinish(self)
    }
}
