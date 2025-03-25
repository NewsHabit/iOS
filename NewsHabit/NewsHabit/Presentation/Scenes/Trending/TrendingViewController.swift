//
//  TrendingViewController.swift
//  NewsHabit
//
//  Created by 지연 on 3/9/25.
//

import Combine
import UIKit

final class TrendingViewController: BaseViewController<TrendingView> {
    private let viewModel: TrendingViewModel
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: UITableViewDiffableDataSource<Int, NewsCellModel>!
    
    // MARK: - Init
    
    init(viewModel: TrendingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
        // 임시
        applySnapshot(with: [
            NewsCellModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .economy),
            NewsCellModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .lifestyle),
            NewsCellModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .politics),
            NewsCellModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .science),
            NewsCellModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .world),
            NewsCellModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .society),
            NewsCellModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .science),
            NewsCellModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .lifestyle),
            NewsCellModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .economy)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.send(.viewWillAppear)
    }
    
    // MARK: - Setup Methods
    
    private func setupTableView() {
        dataSource = .init(
            tableView: trendingNewsTableView,
            cellProvider: { tableView, indexPath, itemIdentifier in
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: NewsCell.self)
                cell.configure(with: itemIdentifier)
                return cell
            }
        )
    }
    
    private func setupBindings() {
        viewModel.state.subTitle
            .sink { [weak self] subTitle in
                self?.subTitleLabel.text = subTitle
            }
            .store(in: &cancellables)
    }
    
    private func applySnapshot(with models: [NewsCellModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, NewsCellModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(models, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

private extension TrendingViewController {
    var subTitleLabel: UILabel {
        contentView.subTitleLabel
    }
    
    var trendingNewsTableView: UITableView {
        contentView.tableView
    }
}
