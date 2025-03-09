//
//  DailyGoalViewController.swift
//  NewsHabit
//
//  Created by 지연 on 3/9/25.
//

import Combine
import UIKit

protocol DailyGoalViewControllerDelegate: AnyObject {
    func dailyGoalDidFinish()
}

final class DailyGoalViewController: BaseViewController<DailyGoalView> {
    weak var delegate: DailyGoalViewControllerDelegate?
    private let viewModel: DailyGoalViewModel
    private var dataSource: UICollectionViewDiffableDataSource<Int, DailyGoalModel>!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: DailyGoalViewModel) {
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
        setupCollectionView()
        setupBindings()
        viewModel.send(.viewDidLoad)
    }
    
    // MARK: - Setup Methods
    
    private func setupCollectionView() {
        collectionView.delegate = self
        dataSource = .init(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                let cell = collectionView.dequeueReusableCell(
                    for: indexPath,
                    cellType: DailyGoalCell.self
                )
                cell.configure(with: itemIdentifier)
                return cell
            }
        )
    }
    
    private func setupBindings() {
        // action
        startButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.dailyGoalDidFinish()
            }
            .store(in: &cancellables)
        
        // state
        viewModel.state.dailyGoalModels
            .sink { [weak self] models in
                self?.applySnapshot(with: models)
            }
            .store(in: &cancellables)
    }
    
    private func applySnapshot(with models: [DailyGoalModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, DailyGoalModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(models, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension DailyGoalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 72)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.send(.dailyGoalCellDidSelect(index: indexPath.row))
    }
}

private extension DailyGoalViewController {
    var collectionView: UICollectionView {
        contentView.collectionView
    }
    
    var startButton: UIButton {
        contentView.startButton
    }
}
