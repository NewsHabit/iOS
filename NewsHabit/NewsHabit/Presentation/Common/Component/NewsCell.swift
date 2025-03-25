//
//  NewsCell.swift
//  NewsHabit
//
//  Created by 지연 on 3/24/25.
//

import UIKit

final class NewsCell: UITableViewCell, Reusable {
    // MARK: - Components
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private let unreadIndicator = {
        let view = UIView()
        view.backgroundColor = .point
        return view
    }()
    
    private let categoryContainer = UIView()
    
    private let categoryLabel = {
        let label = UILabel()
        label.font = .semibold(size: 11)
        return label
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.font = .semibold(size: 16)
        label.textColor = .labelNormal
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.font = .medium(size: 13)
        label.textColor = .labelAssistive
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let line = {
        let view = UIView()
        view.backgroundColor = .lineLight
        return view
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        unreadIndicator.layer.cornerRadius = unreadIndicator.frame.height / 2
        categoryContainer.layer.cornerRadius = categoryContainer.frame.height / 2
    }
    
    // MARK: - Setup Methods
    
    private func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func setupLayout() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview()
        }
        
        stackView.addArrangedSubview(unreadIndicator)
        unreadIndicator.snp.makeConstraints { make in
            make.width.height.equalTo(8)
        }
        
        stackView.addArrangedSubview(categoryContainer)
        
        categoryContainer.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(3)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(3)
            make.leading.trailing.equalToSuperview()
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        }
        
        contentView.addSubview(line)
        line.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    // MARK: - Configure Methods
    
    func configure(with model: NewsCellModel) {
        categoryLabel.text = model.category.name
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        descriptionLabel.setLineHeight(18)
        
        unreadIndicator.isHidden = !model.isUnread
        categoryContainer.backgroundColor = model.isUnread ? .primaryLight : .fillAssistive
        categoryLabel.textColor = model.isUnread ? .primaryStrong : .labelAssistive
    }
}
