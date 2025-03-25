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
    private var todayNewsDataSource: UITableViewDiffableDataSource<Int, NewsCellModel>!
    private var myRecordDataSource: UICollectionViewDiffableDataSource<Int, DayCellModel>!
    private var bookmarkDataSource: UITableViewDiffableDataSource<Int, NewsCellModel>!
    
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
        setupTodayNewsTableView()
        setupMyRecordCollectionView()
        setupBookmarkTableView()
        setupBindings()
        viewModel.send(.viewDidLoad)
    }
    
    // MARK: - Setup Methods
    
    private func setupTodayNewsTableView() {
        todayNewsDataSource = .init(
            tableView: todayNewsView.tableView,
            cellProvider: { tableView, indexPath, itemIdentifier in
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: NewsCell.self)
                cell.configure(with: itemIdentifier)
                return cell
            }
        )
    }
    
    private func setupMyRecordCollectionView() {
        myRecordView.collectionView.delegate = self
        myRecordDataSource = .init(
            collectionView: myRecordView.collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: DayCell.self)
                cell.configure(with: itemIdentifier)
                return cell
            }
        )
    }
    
    private func setupBookmarkTableView() {
        bookmarkDataSource = .init(
            tableView: bookmarkView.tableView,
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
                self?.applyTodayNewsSnapshot(with: models)
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
        
        viewModel.state.myRecordModels
            .sink { [weak self] models in
                self?.applyMyRecordSnapshot(with: models)
            }
            .store(in: &cancellables)
        
        viewModel.state.currentCategory
            .sink { [weak self] category in
                self?.bookmarkView.categoryFilterButton.updateCategory(with: category)
            }
            .store(in: &cancellables)
        
        viewModel.state.bookmarkModels
            .sink { [weak self] models in
                self?.applyBookmarkSnapshot(with: models)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Apply Snapshot
    
    private func applyTodayNewsSnapshot(with models: [NewsCellModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, NewsCellModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(models, toSection: 0)
        todayNewsDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func applyMyRecordSnapshot(with models: [DayCellModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, DayCellModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(models, toSection: 0)
        myRecordDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func applyBookmarkSnapshot(with models: [NewsCellModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, NewsCellModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(models, toSection: 0)
        bookmarkDataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // 셀 간격: 10, 가로:세로 = 7:6
        let width: CGFloat = (collectionView.frame.width - 60.0) / 7.0
        let height: CGFloat = width * 6.0 / 7.0
        return CGSize(width: width, height: height)
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
