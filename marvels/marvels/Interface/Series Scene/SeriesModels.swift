//
//  SeriesModels.swift
//  marvels
//
//  Created by Aitor Pagán on 06/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

enum SeriesModels {
    
    enum GetSeries {
        struct Request {
            let query: String?
            let maxIndex: Int
            let forceRefresh: Bool
        }
        
        struct Response {
            let result: [Serie]
        }
        
        struct Displayed {
            let title: String
            let image: URL
        }
        
        struct ViewModel {
            let viewModel: [Displayed]
        }
        
    }
    
    enum SelectSerie {
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
    
    enum Error {
        
        struct PresentError {
            let error: Swift.Error?
        }
        
        struct DisplayError {
            let title: String?
            let message: String?
        }
    }
    
    enum Loading {
        struct PresentLoading {
        
        }
        
        struct DisplayLoading {
            
        }
    }
}
