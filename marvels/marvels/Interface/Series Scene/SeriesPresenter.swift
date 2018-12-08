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
        let displayed: [SeriesModels.GetSeries.Displayed] = response.result.compactMap({SeriesModels.GetSeries.Displayed.init(title: $0.title ?? "", image: URL(string: $0.thumbnail?.fullPath() ?? "")!)})
        output?.displaySeries(viewModel: SeriesModels.GetSeries.ViewModel.init(viewModel: displayed))
    }
}
