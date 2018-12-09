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
    
    let limit = 20
    var selectedSerie: Any?
    var series: [Serie] = []
    var outputWrapper: SeriesWrapperProtocol?
    var isLoading: Bool = false
    
    var service: SeriesWorkerProtocol? = SeriesWorker(with: SeriesNetworkStore())
    
    func fetchSeries(request: SeriesModels.GetSeries.Request) {
        let lastIndex = request.maxIndex
        let query = request.query
        let forceRefresh = request.forceRefresh
        if (isLoading || (series.count - 1 > lastIndex && lastIndex > 0)) {
            return
        }
        if (forceRefresh) {
            series = []
        }
        let offset = lastIndex == 0 ? lastIndex : series.count
        initLoading()
        service?.fetchSeries(with: query, offset: offset, minCount: limit + series.count, completion: { (series, error) in
            self.isLoading = false
            if(error != nil) {
                self.outputWrapper?.presentError(response: SeriesModels.Error.PresentError.init(error: error))
            }
            
            if let series = series {
                self.series += series
            }
            
            let result = self.series
            self.outputWrapper?.presentSeries(response: SeriesModels.GetSeries.Response.init(result: result))
        })
    }
    
    fileprivate func initLoading() {
        isLoading = true
        outputWrapper?.presentLoading(response: SeriesModels.Loading.PresentLoading())
    }
}
