//
//  SeriesStore.swift
//  marvels
//
//  Created by Aitor Pagán on 07/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

protocol SeriesStore {
    func fetch(query: String?, offset: Int, completion: @escaping ([Serie]?, Error?) -> ())
}

final class SeriesNetworkStore: SeriesStore {
    
    private let apiManager = MarvelAPIManager()
    
    func fetch(query: String?, offset: Int = 0, completion: @escaping ([Serie]?, Error?) -> ()) {
        var queryParams:[String : Any] = query?.isEmpty ?? true ? [:] : ["titleStartsWith" : query!]
        queryParams["offset"] = "\(offset)"
        apiManager.executeRequest(type: [Serie].self, path: MarvelPaths.series, query: queryParams) { (series, error) in
            DispatchQueue.main.async {
                completion(series, error)
            }
        }
    }
}
