//
//  HomeView.swift
//  NewsHabit
//
//  Created by 지연 on 3/9/25.
//

import UIKit

final class HomeView: UIView {
    // MARK: - Components
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "뉴스를 습관처럼, 뉴빗"
        label.font = .bold(size: 24)
        return label
    }()
    
    let bannerButton = {
        let button = UIButton()
        button.setImage(.banner, for: .normal)
        return button
    }()
    
    let homeTab = HomeTab()
    
    let scrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    private let contentView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let todayNewsView = TodayNewsView()
    
    let myRecordView = MyRecordView()
    
    let bookmarkView = BookmarkView()
    
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
        
        addSubview(bannerButton)
        bannerButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        addSubview(homeTab)
        homeTab.snp.makeConstraints { make in
            make.top.equalTo(bannerButton.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
        }
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(homeTab.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(3)
        }
        
        contentView.addArrangedSubview(todayNewsView)
        contentView.addArrangedSubview(myRecordView)
        contentView.addArrangedSubview(bookmarkView)
    }
}
