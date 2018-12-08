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
    
    private static var seriesCache: Set<Serie> = Set<Serie>()
    
    init(with store: SeriesStore) {
        self.seriesStore = store
    }
    
    func cleanCache() {
        SeriesWorker.seriesCache = []
    }
    
    func fetchSeries(with query: String?, offset: Int = 0, minCount: Int = 1, completion: @escaping (([Serie]?, Error?) -> ())) {
        
        let series = filteredSeries(query: query ?? "", by: offset)
        
        if (series.count < minCount || minCount == 0) {
            let newOffset = filteredSeries(query: query ?? "", by: 0).count
            requestMoreSeries(with: query, offset: newOffset) {(newSeries, error) in
                if(newSeries?.count ?? 0 > 0) {
                    SeriesWorker.seriesCache = SeriesWorker.seriesCache.union(newSeries ?? [])
                }
                completion(newSeries,error)
            }
        }
        if(series.count > 0) {
            completion(series, nil)
        }
    }
    
    fileprivate func requestMoreSeries(with query: String?, offset: Int, completion: @escaping (([Serie]?, Error?) -> ())) {
        seriesStore?.fetch(query: query, offset: offset, completion: { (series, error) in
            completion(series, error)
        })
    }
    
    fileprivate func filteredSeries(query: String, by offset: Int = 0) -> [Serie] {
        let index = SeriesWorker.seriesCache.index(SeriesWorker.seriesCache.startIndex, offsetBy: offset)
        return SeriesWorker.seriesCache.suffix(from:index).filter({$0.title?.starts(with: query) ?? true})
    }
}
