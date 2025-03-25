//
//  TrendingView.swift
//  NewsHabit
//
//  Created by 지연 on 3/9/25.
//

import UIKit

final class TrendingView: UIView {
    // MARK: - Components
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "실시간 인기 뉴스"
        label.font = .bold(size: 24)
        label.textColor = .labelNormal
        label.setLineHeight(34)
        return label
    }()
    
    let subTitleLabel = {
        let label = UILabel()
        label.font = .medium(size: 14)
        label.textColor = .labelAssistive
        return label
    }()
    
    let refreshControl = {
        let control = UIRefreshControl()
        control.tintColor = .primaryAssistive
        control.transform = .init(scaleX: 0.7, y: 0.7)
        return control
    }()
    
    lazy var tableView = {
        let tableView = UITableView()
        tableView.registerCell(cellType: NewsCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.refreshControl = refreshControl
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
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
}
