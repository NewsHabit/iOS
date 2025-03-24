//
//  HomeViewController.swift
//  NewsHabit
//
//  Created by 지연 on 3/9/25.
//

import Combine
import UIKit

final class HomeViewController: BaseViewController<HomeView> {
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        homeTab.valuePublisher
            .sink { [weak self] selectedIndex in
                guard let self = self else { return }
                let contentOffsetX = CGFloat(selectedIndex) * view.frame.width
                let contentOffset = CGPoint(x: contentOffsetX, y: 0)
                scrollView.setContentOffset(contentOffset, animated: true)
            }
            .store(in: &cancellables)
    }
}

private extension HomeViewController {
    var homeTab: HomeTab {
        contentView.homeTab
    }
    
    var scrollView: UIScrollView {
        contentView.scrollView
    }
}
