//
//  SeriesPresenter.swift
//  marvels
//
//  Created by Aitor Pagán on 06/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

protocol SeriesWrapperProtocol: class {
    func presentSeries(response: SeriesModels.GetSeries.Response)
}

final class SeriesPresenter: SeriesWrapperProtocol {
    
    weak var output: SeriesOutputProtocol?
    
    func presentSeries(response: SeriesModels.GetSeries.Response) {
        output?.displaySeries(viewModel: SeriesModels.GetSeries.ViewModel())
    }
}
