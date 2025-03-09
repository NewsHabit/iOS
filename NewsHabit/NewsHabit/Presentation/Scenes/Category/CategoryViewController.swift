//
//  CategoryViewController.swift
//  NewsHabit
//
//  Created by 지연 on 3/7/25.
//

import Combine
import UIKit

protocol CategoryViewControllerDelegate: AnyObject {
    func categoryDidFinish()
}

final class CategoryViewController: BaseViewController<CategoryView> {
    weak var delegate: CategoryViewControllerDelegate?
    private let viewModel: CategoryViewModel
    private var dataSource: UICollectionViewDiffableDataSource<Int, CategoryModel>!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: CategoryViewModel) {
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
                    cellType: CategoryCell.self
                )
                cell.configure(with: itemIdentifier)
                return cell
            }
        )
    }
    
    private func setupBindings() {
        // action
        nextButton.tapPublisher
            .sink { [weak self] in
                self?.delegate?.categoryDidFinish()
            }
            .store(in: &cancellables)
        
        // state
        viewModel.state.categoryModels
            .sink { [weak self] models in
                self?.applySnapshot(with: models)
            }
            .store(in: &cancellables)
    }
    
    private func applySnapshot(with models: [CategoryModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CategoryModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(models, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.frame.width - 10) / 2
        return CGSize(width: width, height: 52)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.send(.categoryCellDidSelect(index: indexPath.row))
    }
}

private extension CategoryViewController {
    var collectionView: UICollectionView {
        contentView.collectionView
    }
    
    var nextButton: UIButton {
        contentView.nextButton
    }
}
