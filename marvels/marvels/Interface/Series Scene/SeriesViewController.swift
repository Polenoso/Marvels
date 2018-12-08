//
//  SeriesViewController.swift
//  marvels
//
//  Created by Aitor Pagán on 06/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

protocol SeriesDelegate: class {
    func didSelectItem(at index: IndexPath)
}

protocol SeriesOutputProtocol: class {
    func displaySeries(viewModel: SeriesModels.GetSeries.ViewModel)
}

final class SeriesViewController: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView!
    
    private var seriesCollectionViewDataSource: SeriesCollectionViewDataSource?
    private let seriesDelegate = SeriesCollectionDelegate()
    
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
        setupCollectionView()
        fetchSeries()
    }
    
    private func setupCollectionView() {
        seriesDelegate.delegate = self
        seriesCollectionViewDataSource = SeriesCollectionViewDataSource(items: [], collectionView: self.collectionView, delegate: seriesDelegate)
    }
    
    private func fetchSeries() {
        let request = SeriesModels.GetSeries.Request.init(query: "")
        input?.fetchSeries(request: request)
    }

}

extension SeriesViewController: SeriesOutputProtocol {
    
    func displaySeries(viewModel: SeriesModels.GetSeries.ViewModel) {
        seriesCollectionViewDataSource?.items = viewModel.viewModel
        seriesCollectionViewDataSource?.reloadData()
        view.layoutIfNeeded()
    }
}

extension SeriesViewController: SeriesDelegate {
    func didSelectItem(at index: IndexPath) {
        //TODO call input
    }
}
