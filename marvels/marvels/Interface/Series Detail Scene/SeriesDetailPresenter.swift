//
//  SeriesDetailPresenter.swift
//  marvels
//
//  Created by Aitor Pagán on 09/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

protocol SeriesDetailOutputWrapper {
    func presentDetail(response: SeriesDetailModels.GetDetail.Response)
}

final class SeriesDetailPresenter: SeriesDetailOutputWrapper {
    
    weak var output: SeriesDetailOutput?
    
    func presentDetail(response: SeriesDetailModels.GetDetail.Response) {
        let image = URL(string: response.result.thumbnail?.fullPath() ?? "")!
        let title = response.result.title ?? ""
        var details:[String] = []
        if let description = response.result.description, !description.isEmpty {
            details.append(description)
        }
        if let startYear = response.result.startYear {
            details.append("Start Year: \(startYear)")
        }
        if let endYear = response.result.endYear {
            details.append("End Year: \(endYear)")
        }
        if let type = response.result.type, !type.isEmpty {
            details.append("Type: \(type)")
        }
        if let rating = response.result.rating, !rating.isEmpty {
            details.append("Rating: \(rating)")
        }
        
        let displayed = SeriesDetailModels.GetDetail.Displayed.init(image: image, title: title, details: details)
        
        output?.displayDetail(viewModel: SeriesDetailModels.GetDetail.ViewModel.init(viewModel: displayed))
    }
}
