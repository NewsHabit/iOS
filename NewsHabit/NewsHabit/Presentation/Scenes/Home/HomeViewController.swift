//
//  HomeViewController.swift
//  NewsHabit
//
//  Created by 지연 on 3/9/25.
//

import Combine
import UIKit

final class HomeViewController: BaseViewController<HomeView> {
    private let viewModel: HomeViewModel
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: UITableViewDiffableDataSource<Int, NewsModel>!
    
    // MARK: - Init
    
    init(viewModel: HomeViewModel) {
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
        viewModel.send(.viewDidLoad)
    }
    
    // MARK: - Setup Methods
    
    private func setupTableView() {
        dataSource = .init(
            tableView: todayNewsView.tableView,
            cellProvider: { tableView, indexPath, itemIdentifier in
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: NewsCell.self)
                cell.configure(with: itemIdentifier)
                return cell
            }
        )
    }
    
    private func setupBindings() {
        // action
        homeTab.valuePublisher
            .sink { [weak self] selectedIndex in
                guard let self = self else { return }
                let contentOffsetX = CGFloat(selectedIndex) * view.frame.width
                let contentOffset = CGPoint(x: contentOffsetX, y: 0)
                scrollView.setContentOffset(contentOffset, animated: true)
            }
            .store(in: &cancellables)
        
        // state
        viewModel.state.allReadCount
            .sink { [weak self] allReadCount in
                self?.todayNewsView.allReadView.configure(with: allReadCount)
            }
            .store(in: &cancellables)
        
        viewModel.state.todayNewsModels
            .sink { [weak self] models in
                self?.applySnapshot(with: models)
            }
            .store(in: &cancellables)
        
        viewModel.state.currentYearMonth
            .sink { [weak self] currentYearMonth in
                self?.myRecordView.yearMonthLabel.text = currentYearMonth
            }
            .store(in: &cancellables)
        
        viewModel.state.isPrevButtonEnabled
            .sink { [weak self] isEnabled in
                self?.myRecordView.prevButton.isEnabled = isEnabled
            }
            .store(in: &cancellables)
        
        viewModel.state.isNextButtonEnabled
            .sink { [weak self] isEnabled in
                self?.myRecordView.nextButton.isEnabled = isEnabled
            }
            .store(in: &cancellables)
        
        viewModel.state.monthlyAllReadCount
            .sink { [weak self] monthlyAllReadCount in
                self?.myRecordView.monthlyAllReadLabel.text = String(monthlyAllReadCount)
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
    
    var todayNewsView: TodayNewsView {
        contentView.todayNewsView
    }
    
    var myRecordView: MyRecordView {
        contentView.myRecordView
    }
    
    var bookmarkView: BookmarkView {
        contentView.bookmarkView
    }
}
