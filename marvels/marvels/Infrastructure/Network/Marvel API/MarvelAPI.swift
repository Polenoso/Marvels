//
//  MarvelAPI.swift
//  marvels
//
//  Created by Aitor Pagán on 07/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

private struct MarvelAPIConfig {
    static let apiversion = Environment.configuration(.marvelApiVersion)
    static let baseUrl = Environment.configuration(.marvelBaseUrl)
    static let apiKey = Environment.configuration(.marvelApiKey)
    static let privateKey = Environment.configuration(.marvelPrivateKey)
    static let ts = Date().timeIntervalSince1970.description
    static let hash = "\(ts)\(privateKey)\(apiKey)".md5Digest()
}

enum MarvelPaths: String {
    case series = "series"
    
    func method() -> NetworkRequestMethod {
        switch self {
        default:
            return NetworkRequestMethod.get
        }
    }
}

protocol MarvelApiFacade {
    func executeRequest<T:Decodable>(type: T.Type, path: MarvelPaths, query: [String : Any]?, completion: @escaping ((T?,Error?) -> ()))
}

final class MarvelAPIManager: MarvelApiFacade {
    
    private let defaultParameters: [String: Any] = ["ts": MarvelAPIConfig.ts,
                             "apikey" : MarvelAPIConfig.apiKey,
                             "hash": MarvelAPIConfig.hash]
    
    private let defaultApiHeaders: [String : String] = [:]
    
    private let defaultParsingPath = "data.results"
    

    func executeRequest<T>(type: T.Type, path: MarvelPaths, query: [String : Any]?, completion: @escaping ((T?, Error?) -> ())) where T : Decodable {
        
        let params = defaultParameters.merging(query ?? [:], uniquingKeysWith: { (_, new) -> Any in
            return new
        })
        
        let url = URL(string: "\(MarvelAPIConfig.baseUrl)/\(path.rawValue)")!
        
        let networkRequest = NetworkRequest.init(url: url, parameters: params, headers: defaultApiHeaders, method: path.method(), parsingPath: defaultParsingPath)
        
        Network.shared.requestData(type: type, request: networkRequest) { (data, error) in
            completion(data,error)
        }
    }
    
}
