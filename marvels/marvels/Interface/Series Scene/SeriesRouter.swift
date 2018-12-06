//
//  SeriesRouter.swift
//  marvels
//
//  Created by Aitor Pagán on 06/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

protocol SeriesNavigationProtocol: class {
    func navigateToDetail()
}

protocol SeriesDataPassing {
    var dataSource: SeriesDataSource? { get set }
}

final class SeriesRouter: SeriesNavigationProtocol, SeriesDataPassing {
    
    var dataSource: SeriesDataSource?
    weak var viewController: SeriesViewController?
    
    func navigateToDetail() {
        
    }
}
