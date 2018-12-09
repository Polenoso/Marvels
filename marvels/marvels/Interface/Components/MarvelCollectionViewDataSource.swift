//
//  MarvelCollectionViewDataSource.swift
//  marvels
//
//  Created by Aitor Pagán on 08/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import UIKit

protocol MarvelCollectionViewDataSource: UICollectionViewDataSource {
    
    associatedtype T
    var items:[T] {get}
    var collectionView: UICollectionView? {get}
    var delegate: UICollectionViewDelegate? {get}
    
    init(items: [T], collectionView: UICollectionView, delegate: UICollectionViewDelegate)
    
    func setup()
}

extension MarvelCollectionViewDataSource {
    
    func setup() {
        collectionView?.dataSource = self
        collectionView?.delegate = delegate
        collectionView?.reloadData()
    }
}
