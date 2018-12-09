//
//  SeriesDetailViewController.swift
//  marvels
//
//  Created by Aitor Pagán on 09/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

protocol SeriesDetailOutput: class {
    func displayDetail(viewModel: SeriesDetailModels.GetDetail.ViewModel)
}

class SeriesDetailViewController: UIViewController {
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var serieImageView: UIImageView!
    @IBOutlet var serieTitleLabel: UILabel!
    @IBOutlet var serieContentStackView: UIStackView!
    
    var input: SeriesDetailInput?
    var router: (SeriesDetailNavigationProtocol & SeriesDetailDataPassing)?
    
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
    
    fileprivate func setup() {
        let presenter = SeriesDetailPresenter()
        let interactor = SeriesDetailInteractor()
        let viewController = self
        let navigator = SeriesDetailRouter()
        
        input = interactor
        interactor.outputWrapper = presenter
        router = navigator
        navigator.dataSource = interactor
        presenter.output = viewController
        navigator.viewController = viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.backgroundColor = UIColor.clear
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        input?.fetchDetail(request: SeriesDetailModels.GetDetail.Request())
    }

    fileprivate func defaultLabel(with text: String) -> UILabel{
        let label = UILabel(frame: .zero)
        label.text = text
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }
    
    @IBAction func closeButtonTap(sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension SeriesDetailViewController: SeriesDetailOutput {
    func displayDetail(viewModel: SeriesDetailModels.GetDetail.ViewModel) {
        let data = viewModel.viewModel
        serieImageView.setImage(url: data.image)
        serieTitleLabel.text = data.title
        
        for text in data.details ?? [] {
            serieContentStackView.addArrangedSubview(defaultLabel(with: text))
        }
        
        view.setNeedsLayout()
    }
}
