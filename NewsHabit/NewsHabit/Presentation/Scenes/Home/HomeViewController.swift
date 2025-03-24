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
    private var dataSource: UITableViewDiffableDataSource<Int, NewsModel>!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
        // 임시
        allReadView.configure(with: 8)
        applySnapshot(with: [
            NewsModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .science, isUnread: true),
            NewsModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .lifestyle, isUnread: true),
            NewsModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .economy, isUnread: true)
        ])
    }
    
    // MARK: - Setup Methods
    
    private func setupTableView() {
        dataSource = .init(
            tableView: todayNewsTableView,
            cellProvider: { tableView, indexPath, itemIdentifier in
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: NewsCell.self)
                cell.configure(with: itemIdentifier)
                return cell
            }
        )
    }
    
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
    
    private func applySnapshot(with models: [NewsModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, NewsModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(models, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

private extension HomeViewController {
    var homeTab: HomeTab {
        contentView.homeTab
    }
    
    var scrollView: UIScrollView {
        contentView.scrollView
    }
    
    var allReadView: AllReadView {
        contentView.todayNewsView.allReadView
    }
    
    var todayNewsTableView: UITableView {
        contentView.todayNewsView.tableView
    }
}
