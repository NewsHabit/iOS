//
//  TodayNewsView.swift
//  NewsHabit
//
//  Created by 지연 on 3/24/25.
//

import UIKit

final class TodayNewsView: UIView {
    // MARK: - Components
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    let allReadView = AllReadView()
    
    let tableView = {
        let tableView = UITableView()
        tableView.registerCell(cellType: NewsCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        return tableView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        stackView.addArrangedSubview(allReadView)
        stackView.addArrangedSubview(tableView)
    }
}
