//
//  SplashViewController.swift
//  NewsHabit
//
//  Created by 지연 on 3/1/25.
//

import UIKit

protocol SplashViewControllerDelegate: AnyObject {
    func didSplashFinish()
}

final class SplashViewController: UIViewController {
    weak var delegate: SplashViewControllerDelegate?
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = SplashView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.delegate?.didSplashFinish()
        }
    }
}
