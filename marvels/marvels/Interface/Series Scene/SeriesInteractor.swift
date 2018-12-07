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
    
    var service: SeriesWorkerProtocol? = SeriesWorker(with: SeriesNetworkStore())
    
    func fetchSeries(request: SeriesModels.GetSeries.Request) {
        service?.fetchSeries(with: "", offset: series.count, minCount: limit + series.count, completion: { (series, error) in
            if(error != nil) {
                //Present Error
            }
            
            if let series = series {
                self.series = series
            }
            
            if self.series.count == 0 {
                //Empty wrapper
            } else {
                let result = self.series
                self.outputWrapper?.presentSeries(response: SeriesModels.GetSeries.Response.init(result: result))
            }
        })
    }
}
