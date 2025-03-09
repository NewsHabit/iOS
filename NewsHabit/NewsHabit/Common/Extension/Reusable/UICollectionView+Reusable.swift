//
//  UICollectionView+Reusable.swift
//  NewsHabit
//
//  Created by 지연 on 3/7/25.
//

import UIKit

extension UICollectionView {
    final func registerCell<Cell: UICollectionViewCell>(cellType: Cell.Type) where Cell: Reusable {
        self.register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableCell<Cell: UICollectionViewCell>(
        for indexPath: IndexPath,
        cellType: Cell.Type = Cell.self
    ) -> Cell where Cell: Reusable {
        guard let cell = self.dequeueReusableCell(
            withReuseIdentifier: cellType.reuseIdentifier,
            for: indexPath
        ) as? Cell else {
            fatalError("Could not dequeue cell with identifier: \(cellType.reuseIdentifier)")
        }
        return cell
    }
    
    final func registerHeader<Header: UICollectionReusableView>(
        viewType: Header.Type
    ) where Header: Reusable {
        self.register(
            viewType.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: viewType.reuseIdentifier
        )
    }
    
    final func dequeueReusableHeader<Header: UICollectionReusableView>(
        for indexPath: IndexPath,
        viewType: Header.Type = Header.self
    ) -> Header where Header: Reusable {
        guard let view = self.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: viewType.reuseIdentifier,
            for: indexPath
        ) as? Header else {
            fatalError("Could not dequeue header with identifier: \(viewType.reuseIdentifier)")
        }
        return view
    }
}
