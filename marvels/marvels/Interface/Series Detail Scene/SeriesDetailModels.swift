//
//  SeriesDetailModels.swift
//  marvels
//
//  Created by Aitor Pagán on 09/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

enum SeriesDetailModels {
    
    enum GetDetail {
        
        struct Displayed {
            let image: URL
            let title: String
            let details: [String]?
        }
        
        struct Request {}
        
        struct Response {
            let result: Serie
        }
        
        struct ViewModel {
            let viewModel: Displayed
        }
    }
}
