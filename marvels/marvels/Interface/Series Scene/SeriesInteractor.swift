//
//  SeriesInteractor.swift
//  marvels
//
//  Created by Aitor Pagán on 06/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

protocol SeriesInputProtocol: class {
    func fetchSeries(request: SeriesModels.GetSeries.Request)
}

protocol SeriesDataSource {
    var selectedSerie: Any? { get }
}

final class SeriesInteractor: SeriesInputProtocol, SeriesDataSource {
    
    var selectedSerie: Any?
    var outputWrapper: SeriesWrapperProtocol?
    
    var service: SeriesWorkerProtocol? = SeriesWorker(with: SeriesNetworkStore())
    
    func fetchSeries(request: SeriesModels.GetSeries.Request) {
        outputWrapper?.presentSeries(response: SeriesModels.GetSeries.Response())
    }
}
