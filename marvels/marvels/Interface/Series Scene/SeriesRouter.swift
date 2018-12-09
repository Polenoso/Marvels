//
//  SeriesRouter.swift
//  marvels
//
//  Created by Aitor Pagán on 06/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import UIKit

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
        let storyboard = UIStoryboard(name: "SeriesDetail", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "SeriesDetailViewController") as! SeriesDetailViewController
        vc.router?.dataSource?.serie = self.dataSource?.selectedSerie
        viewController?.present(vc, animated: true, completion: nil)
    }
}
