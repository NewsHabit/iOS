//
//  BookmarkView.swift
//  NewsHabit
//
//  Created by 지연 on 3/24/25.
//

import UIKit

final class BookmarkView: UIView {
    // MARK: - Components
    
    let categoryFilterButton = CategoryFilterButton()
    
    let tableView = {
        let tableView = UITableView()
        tableView.registerCell(cellType: NewsCell.self)
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
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
        addSubview(categoryFilterButton)
        categoryFilterButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(categoryFilterButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
}
