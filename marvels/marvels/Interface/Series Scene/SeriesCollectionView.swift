//
//  SeriesCollectionView.swift
//  marvels
//
//  Created by Aitor Pagán on 08/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

final class SeriesCollectionViewDataSource: NSObject, MarvelCollectionViewDataSource {
    
    typealias T = SeriesModels.GetSeries.Displayed
    
    var items: [SeriesModels.GetSeries.Displayed] = []
    weak var delegate: UICollectionViewDelegate?
    weak var collectionView: UICollectionView?
    
    init(items: [T], collectionView: UICollectionView, delegate: UICollectionViewDelegate) {
        self.items = items
        self.collectionView = collectionView
        self.delegate = delegate
        super.init()
        self.collectionView?.register(UINib.init(nibName: SeriesCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: SeriesCollectionViewCell.reuseIdentifier)
        if let layoutDelegate = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layoutDelegate.itemSize = CGSize(width: 350, height: 450)
        }
        self.setup()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesCollectionViewCell.reuseIdentifier, for: indexPath) as! SeriesCollectionViewCell
        cell.updateUI(item: items[indexPath.item])
        return cell
    }
    
    func reloadData() {
        collectionView?.reloadData()
    }
}

final class SeriesCollectionDelegate: NSObject, UICollectionViewDelegate {
    
    weak var delegate: SeriesDelegate?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SeriesCollectionViewCell {
            UIView.animate(withDuration: 0.25) {
                cell.backgroundContainerView.transform = .init(scaleX: 0.97, y: 0.97)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SeriesCollectionViewCell {
            UIView.animate(withDuration: 0.25) {
                cell.backgroundContainerView.transform = .identity
            }
        }
    }
    
}

extension SeriesCollectionDelegate: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        delegate?.prefetchItems(at: indexPaths)
    }
    
}
