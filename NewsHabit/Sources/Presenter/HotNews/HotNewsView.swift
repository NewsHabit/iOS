//
//  HotNewsView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import Combine
import UIKit

final class HotNewsView: UIView, BaseViewProtocol {
    
    var delegate: HotNewsViewDelegate?
    private var viewModel: HotNewsViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    let tableView = UITableView().then {
        $0.backgroundColor = .background
        $0.register(HotNewsCell.self, forCellReuseIdentifier: HotNewsCell.reuseIdentifier)
    }
    
    let refreshControl = UIRefreshControl()
    
    let errorView = ErrorView()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    func setupProperty() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        errorView.isUserInteractionEnabled = true
        errorView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(refreshNews)))
    }
    
    func setupHierarchy() {
        addSubview(tableView)
        addSubview(errorView)
    }
    
    func setupLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        errorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    @objc private func refreshNews() {
        self.viewModel?.input.send(.getHotNews)
    }
    
    // MARK: - Bind ViewModel
    
    func bindViewModel(_ viewModel: HotNewsViewModel) {
        self.viewModel = viewModel
        viewModel.transform(input: viewModel.input.eraseToAnyPublisher())
            .receive(on: RunLoop.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .updateHotNews:
                    self.errorView.isHidden = true
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                    self.delegate?.updateDate()
                case .fetchFailed:
                    self.errorView.isHidden = false
                    self.tableView.isHidden = true
                    self.refreshControl.endRefreshing()
                case let .navigateTo(newsLink):
                    self.delegate?.pushViewController(newsLink)
                }
            }.store(in: &cancellables)
    }
    
}

extension HotNewsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.input.send(.tapNewsCell(indexPath.row))
    }
    
}

extension HotNewsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HotNewsCell.reuseIdentifier) as? HotNewsCell,
              let cellViewModel = viewModel?.cellViewModels[indexPath.row] else { return UITableViewCell() }
        cell.bindViewModel(cellViewModel)
        return cell
    }
    
}

