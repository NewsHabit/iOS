//
//  TodayNewsCountView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/14/24.
//

import Combine
import UIKit

protocol TodayNewsCountViewDelegate: AnyObject {
    func popViewController()
}

final class TodayNewsCountView: UIView, BaseViewProtocol {
    
    weak var delegate: TodayNewsCountViewDelegate?
    private var viewModel: TodayNewsCountViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.text = "매일 추천받고 싶은 기사의 개수를 선택해주세요"
        $0.textColor = .label
        $0.font = .bodySB
    }
    
    private let subTitleLabel = UILabel().then {
        $0.textColor = .newsHabitGray
        $0.font = .title3
    }
    
    private let tableView = UITableView().then {
        $0.backgroundColor = .background
        $0.separatorStyle = .none
        $0.register(TodayNewsCountCell.self, forCellReuseIdentifier: TodayNewsCountCell.reuseIdentifier)
    }
    
    private let saveButton = UIButton().then {
        $0.configuration = .plain()
        $0.configuration?.attributedTitle = .init("저장", attributes: .init([.font: UIFont.body]))
        $0.tintColor = .white
        $0.backgroundColor = .black
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
    }
    
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
    
    // MARK: - BaseViewProtocol
    
    func setupProperty() {
        tableView.delegate = self
        tableView.dataSource = self
        saveButton.addTarget(self, action: #selector(handleSaveButtonTap), for: .touchUpInside)
    }
    
    @objc private func handleSaveButtonTap() {
        guard let viewModel = viewModel else { return }
        UserDefaultsManager.todayNewsCount = TodayNewsCountType.count(from: viewModel.selectedIndex)
        delegate?.popViewController()
    }
    
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(tableView)
        addSubview(saveButton)
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalToSuperview().inset(30)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(saveButton.snp.top).offset(20)
        }
        
        saveButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(50)
            $0.height.equalTo(44)
        }
    }
    
    func setSubTitle(with text: String) {
        subTitleLabel.text = text
    }
    
    func setSaveButtonHidden() {
        saveButton.isHidden = true
    }
    
    // MARK: - Bind
    
    func bind(with viewModel: TodayNewsCountViewModel) {
        self.viewModel = viewModel
        
        viewModel.$selectedIndex
            .receive(on: RunLoop.main)
            .sink { [weak self] selectedIndex in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
}

extension TodayNewsCountView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectedIndex = indexPath.row
    }
    
}

extension TodayNewsCountView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodayNewsCountType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel,
              let cell = tableView.dequeueReusableCell(withIdentifier: TodayNewsCountCell.reuseIdentifier) as? TodayNewsCountCell
        else { return UITableViewCell() }
        let todayNewsCount = TodayNewsCountType.allCases[indexPath.row]
        cell.configure(with: todayNewsCount.rawValue)
        cell.setSelected(viewModel.selectedIndex == indexPath.row)
        return cell
    }
    
}
