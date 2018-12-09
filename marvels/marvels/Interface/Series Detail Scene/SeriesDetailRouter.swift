//
//  SeriesDetailRouter.swift
//  marvels
//
//  Created by Aitor Pagán on 09/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

protocol SeriesDetailNavigationProtocol {
    
}

protocol SeriesDetailDataPassing {
    var dataSource: SeriesDetailDataSource? { get set }
}

final class SeriesDetailRouter: SeriesDetailNavigationProtocol, SeriesDetailDataPassing {
    
    weak var viewController: SeriesDetailViewController?
    
    var dataSource: SeriesDetailDataSource?
}
