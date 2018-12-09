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
    func navigateToDetail(_ sourceRect: CGRect)
}

protocol SeriesDataPassing {
    var dataSource: SeriesDataSource? { get set }
}

final class SeriesRouter: SeriesNavigationProtocol, SeriesDataPassing {
    
    var dataSource: SeriesDataSource?
    weak var viewController: SeriesViewController?
    
    private var transitionDelegate: UIViewControllerTransitioningDelegate?
    
    func navigateToDetail(_ sourceRect: CGRect = .zero) {
        let storyboard = UIStoryboard(name: "SeriesDetail", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "SeriesDetailViewController") as! SeriesDetailViewController
        vc.router?.dataSource?.serie = self.dataSource?.selectedSerie
        transitionDelegate = CollectionCardTransitionContext(sourceRect)
        vc.transitioningDelegate = transitionDelegate
        viewController?.present(vc, animated: true, completion: nil)
    }
}
