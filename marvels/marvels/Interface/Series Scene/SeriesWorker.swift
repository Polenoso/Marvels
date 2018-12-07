//
//  SeriesWorker.swift
//  marvels
//
//  Created by Aitor Pagán on 06/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

typealias SeriesCompletionBlock = ([Serie]?, Error?) -> ()

protocol SeriesWorkerProtocol: class {
    func cleanCache()
    func fetchSeries(with query:String?, offset: Int, minCount: Int, completion: @escaping (SeriesCompletionBlock))
}

final class SeriesWorker: SeriesWorkerProtocol {
    
    var seriesStore: SeriesStore?
    
    var seriesCache: Set<Serie> = Set<Serie>()
    
    init(with store: SeriesStore) {
        self.seriesStore = store
    }
    
    func cleanCache() {
        seriesCache = []
    }
    
    func fetchSeries(with query: String?, offset: Int = 0, minCount: Int = 1, completion: @escaping (([Serie]?, Error?) -> ())) {
        
        var series = filteredSeries(query: query ?? "")
        
        if (series.count < minCount) {
            requestMoreSeries(with: query, offset: min(offset, seriesCache.count)) { (newSeries, error) in
                if(newSeries?.count ?? 0 > 0) {
                    self.seriesCache.formUnion(newSeries ?? [])
                }
                series = self.filteredSeries(query: query ?? "")
                completion(series,error)
            }
        }
    }
    
    fileprivate func requestMoreSeries(with query: String?, offset: Int, completion: @escaping (([Serie]?, Error?) -> ())) {
        seriesStore?.fetch(query: query, offset: offset, completion: { (series, error) in
            completion(series, error)
        })
    }
    
    fileprivate func filteredSeries(query: String) -> [Serie] {
        return seriesCache.filter({$0.title?.starts(with: query) ?? true})
    }
}
