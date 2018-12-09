//
//  SeriesDetailInteractor.swift
//  marvels
//
//  Created by Aitor Pagán on 09/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

protocol SeriesDetailInput {
    func fetchDetail(request: SeriesDetailModels.GetDetail.Request)
}

protocol SeriesDetailDataSource {
    var serie: Serie? { get set }
}

final class SeriesDetailInteractor: SeriesDetailInput, SeriesDetailDataSource {
    
    var serie: Serie?
    
    var outputWrapper: SeriesDetailOutputWrapper?
    
    func fetchDetail(request: SeriesDetailModels.GetDetail.Request) {
        guard let serie = serie else {
            return
        }
        
        outputWrapper?.presentDetail(response: SeriesDetailModels.GetDetail.Response.init(result: serie))
    }
}
