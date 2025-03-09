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
        navigationController.pushViewController(viewController, animated: false)
    }
}
