//
//  HourSelectionView.swift
//  NewsHabit
//
//  Created by 지연 on 3/12/25.
//

import Combine
import UIKit

final class HourSelectionView: UIView {
    private let hours = Hour.allCases
    var valuePublisher = PassthroughSubject<Hour, Never>()
    
    var hour: Hour? {
        didSet {
            setupHour()
        }
    }
    
    // MARK: - Components
    
    private let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 9
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerCell(cellType: NotificationTimeCell.self)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupCollectionView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(118)
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupHour() {
        guard let hour = hour,
              let index = hours.firstIndex(of: hour)
        else { return }
        collectionView.selectItem(
            at: IndexPath(row: index, section: 0),
            animated: false,
            scrollPosition: []
        )
    }
}

extension HourSelectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // 셀 간격: 9, 한 줄 최대 개수: 4
        let width = (collectionView.frame.width - 9 * 3) / 4
        return CGSize(width: width, height: 34)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        valuePublisher.send(hours[indexPath.row])
    }
}

extension HourSelectionView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return hours.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            for: indexPath,
            cellType: NotificationTimeCell.self
        )
        cell.configure(with: hours[indexPath.row].rawValue)
        return cell
    }
}
