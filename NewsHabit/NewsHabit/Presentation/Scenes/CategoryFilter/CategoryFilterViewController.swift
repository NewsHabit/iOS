//
//  CategoryFilterViewController.swift
//  NewsHabit
//
//  Created by 지연 on 3/25/25.
//

import Combine
import UIKit

final class CategoryFilterViewController: BottomSheetViewController<CategoryFilterView> {
    private let viewModel: CategoryFilterViewModel
    private var dataSource: UICollectionViewDiffableDataSource<Int, CategoryFilterCellModel>!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: CategoryFilterViewModel) {
        self.viewModel = viewModel
        super.init(bottomSheetHeight: 513)
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
        categoryFilterCollectionView.delegate = self
        dataSource = .init(
            collectionView: categoryFilterCollectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                let cell = collectionView.dequeueReusableCell(
                    for: indexPath,
                    cellType: CategoryFilterCell.self
                )
                cell.configure(with: itemIdentifier)
                return cell
            }
        )
    }
    
    private func setupBindings() {
        viewModel.state.categoryFilterModels
            .sink { [weak self] models in
                self?.applySnapshot(with: models)
            }
            .store(in: &cancellables)
    }
    
    private func applySnapshot(with models: [CategoryFilterCellModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CategoryFilterCellModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(models, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension CategoryFilterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.send(.categoryFilterCellDidSelect(index: indexPath.row))
    }
}

private extension CategoryFilterViewController {
    var categoryFilterCollectionView: UICollectionView {
        contentView.collectionView
    }
}
