//
//  SeriesViewController.swift
//  marvels
//
//  Created by Aitor Pagán on 06/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

protocol SeriesOutputProtocol: class {
    func displaySeries(viewModel: SeriesModels.GetSeries.ViewModel)
}

final class SeriesViewController: UIViewController {
    
    var input: SeriesInputProtocol?
    var router: (SeriesNavigationProtocol & SeriesDataPassing)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let presenter = SeriesPresenter()
        let interactor = SeriesInteractor()
        let viewController = self
        let navigator = SeriesRouter()
        
        input = interactor
        interactor.outputWrapper = presenter
        router = navigator
        navigator.dataSource = interactor
        presenter.output = viewController
        navigator.viewController = viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func fetchSeries() {
        input?.fetchSeries(request: SeriesModels.GetSeries.Request())
    }

}

extension SeriesViewController: SeriesOutputProtocol {
    
    func displaySeries(viewModel: SeriesModels.GetSeries.ViewModel) {
        
    }
}
