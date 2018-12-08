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
    func prefetchItems(at index: [IndexPath])
}

protocol SeriesOutputProtocol: class {
    func displaySeries(viewModel: SeriesModels.GetSeries.ViewModel)
    func displayLoading(viewModel: SeriesModels.Loading.DisplayLoading)
    func displayError(viewModel: SeriesModels.Error.DisplayError)
}

final class SeriesViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
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
        collectionView.prefetchDataSource = seriesDelegate
        seriesDelegate.delegate = self
        seriesCollectionViewDataSource = SeriesCollectionViewDataSource(items: [], collectionView: self.collectionView, delegate: seriesDelegate)
    }
    
    private func fetchSeries(_ index: Int = 0, query: String? = "", force: Bool = false) {
        let request = SeriesModels.GetSeries.Request.init(query: query, maxIndex: index, forceRefresh: force)
        input?.fetchSeries(request: request)
    }

}

extension SeriesViewController: SeriesOutputProtocol {
    
    func displaySeries(viewModel: SeriesModels.GetSeries.ViewModel) {
        hideLoading()
        seriesCollectionViewDataSource?.items = viewModel.viewModel
        seriesCollectionViewDataSource?.reloadData()
        view.layoutIfNeeded()
    }
    
    func displayLoading(viewModel: SeriesModels.Loading.DisplayLoading) {
        displayLoading()
    }
    
    func displayError(viewModel: SeriesModels.Error.DisplayError) {
        displayErrorMessage(viewModel.message, title: viewModel.title)
    }
}

extension SeriesViewController: SeriesDelegate {
    func prefetchItems(at index: [IndexPath]) {
        fetchSeries(index.last?.item ?? 0)
    }
    
    func didSelectItem(at index: IndexPath) {
        //TODO call input
    }
}

extension SeriesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        fetchSeries(0, query: searchBar.text, force: true)
        if self.seriesCollectionViewDataSource?.items.count ?? 0 > 0 {
            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        }
        
    }
}
