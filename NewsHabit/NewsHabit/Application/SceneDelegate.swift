//
//  SceneDelegate.swift
//  NewsHabit
//
//  Created by 지연 on 3/1/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let splashViewController = SplashViewController()
        splashViewController.delegate = self
        window?.rootViewController = splashViewController
        window?.makeKeyAndVisible()
        window?.backgroundColor = .background
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

extension SceneDelegate: SplashViewControllerDelegate {
    func didSplashFinish() {
        print("finish")
    }
}
