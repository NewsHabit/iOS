//
//  AppCoordinator.swift
//  NewsHabit
//
//  Created by 지연 on 3/9/25.
//

import UIKit

final class AppCoordinator: Coordinator {
    private var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if needsOnboarding() {
            showOnboardingFlow()
        } else {
            showMainFlow()
        }
    }
    
    private func needsOnboarding() -> Bool {
        return false
    }
    
    private func showOnboardingFlow() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        
        let onboardingCoordinator = OnboardingCoordinator(
            navigationController: navigationController
        )
        
        onboardingCoordinator.delegate = self
        store(coordinator: onboardingCoordinator)
        onboardingCoordinator.start()
    }
    
    private func showMainFlow() {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        window.rootViewController = navigationController
        
        let mainCoordinator = MainCoordinator(
            navigationController: navigationController
        )
        
        mainCoordinator.delegate = self
        store(coordinator: mainCoordinator)
        mainCoordinator.start()
    }
    
    // MARK: - Util Methods
    
    private func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    private func free(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

extension AppCoordinator: OnboardingCoordinatorDelegate {
    func onboardingDidFinish(_ coordinator: OnboardingCoordinator) {
        free(coordinator: coordinator)
        showMainFlow()
    }
}

extension AppCoordinator: MainCoordinatorDelegate {
    func mainDidFinish(_ coordinator: MainCoordinator) {
        free(coordinator: coordinator)
        showOnboardingFlow()
    }
}
