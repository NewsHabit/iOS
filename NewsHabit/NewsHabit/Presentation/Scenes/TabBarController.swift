//
//  TabBarController.swift
//  NewsHabit
//
//  Created by 지연 on 3/9/25.
//

import UIKit

final class TabBarController: UITabBarController {
    // MARK: - Components
    
    private let line = {
        let view = UIView()
        view.backgroundColor = .lineLight
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupLayout()
    }
    
    // MARK: - Setup Methods
    
    private func setupTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .labelNormal
        tabBar.unselectedItemTintColor = .labelNormal
        tabBar.isTranslucent = false
        
        viewControllers = [
            makeViewController(from: UIViewController(), image: .home, selectedImage: .homeFill),
            makeViewController(from: UIViewController(), image: .news, selectedImage: .newsFill),
            makeViewController(from: UIViewController(), image: .settings, selectedImage: .settingsFill)
        ]
    }
    
    private func makeViewController(
        from viewController: UIViewController,
        image: UIImage,
        selectedImage: UIImage
    ) -> UIViewController {
        let tabBarItem = UITabBarItem(title: nil, image: image, selectedImage: selectedImage)
        viewController.tabBarItem = tabBarItem
        return UINavigationController(rootViewController: viewController)
    }
    
    private func setupLayout() {
        tabBar.addSubview(line)
        line.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
