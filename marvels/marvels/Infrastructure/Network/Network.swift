//
//  Network.swift
//  marvels
//
//  Created by Aitor Pagán on 06/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import Alamofire

/*
 Parsing Path must be separated by "."
 */
public struct NetworkRequest {
    let url: URL
    let parameters: [String: Any]?
    let headers: [String: String]?
    let method: NetworkRequestMethod
    let parsingPath: String?
}

public enum NetworkRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case path = "PATH"
    
    fileprivate func toHTTPMethod() throws -> HTTPMethod {
        guard let method = HTTPMethod(rawValue: self.rawValue) else {
            throw NetworkError.invalid("method not valid")
        }
        return method
    }
}

public enum NetworkError: Swift.Error {
    case parsing(String)
    case invalid(String)
    case request(String)
    case timeout(String)
}

public protocol NetworkFacade: class {
    func requestData<T:Decodable>(type: T.Type, request: NetworkRequest, completion:@escaping (T?,Error?) -> ())
}

final class Network: NetworkFacade {
    
    static let shared: Network = Network()
    
    private var networkManager: NetworkManager?
    
    private init(){
        networkManager = NetworkManager()
    }
    
    func requestData<T>(type: T.Type, request: NetworkRequest, completion: @escaping (T?, Error?) -> ()) where T : Decodable {
        do {
            let method = try request.method.toHTTPMethod()
            let params = request.parameters
            let headers = request.headers
            let url = request.url
            let parsingPath: [String] = request.parsingPath?.split(separator: ".").map({String($0)}) ?? []
      
            networkManager?.request(url, method: method, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON(queue: DispatchQueue.global(), options: JSONSerialization.ReadingOptions.allowFragments) { (response) in
                debugPrint(response.request?.debugDescription ?? "")
                let error = response.error
                let result = response.result
                do {
                    guard error == nil else {
                        throw error!
                    }
                    
                    switch result {
                    case .success(let json):
                        guard let resultDict = json as? [String : Any] else {
                            throw NetworkError.parsing("Not a valid json")
                        }
                        
                        debugPrint(resultDict)
                        if (resultDict["error"] != nil) {
                            throw NetworkError.request(resultDict["message"] as! String)
                        }
                        var data: Data
                        var dataDict: [String : Any] = ["result" : resultDict]
                        if(parsingPath.count > 0) {
                            dataDict = dataDict["result"] as! [String : Any]
                            for path in parsingPath {
                                if (dataDict["error"] != nil) {
                                    throw NetworkError.request(resultDict["message"] as! String)
                                }
                                
                                if let dataPath = dataDict[path] as? [String : Any] {
                                    dataDict = dataPath
                                } else {
                                    guard let dataPath = dataDict[path] as? [[String : Any]] else {
                                        throw NetworkError.parsing("Error parsing response at \(path)")
                                    }
                                    dataDict = ["result" : dataPath]
                                }
                                
                            }
                        }
                        
                        data = try JSONSerialization.data(withJSONObject: dataDict["result"]!, options: .prettyPrinted)
                        let dataResponse: T = try JSONDecoder().decode(T.self, from: data)
                        completion(dataResponse, nil)
                    case .failure(let error):
                        throw error
                    }
                    
                } catch {
                    completion(nil, error)
                }
            }
        } catch {
            completion(nil, error)
        }
    }
}


private struct Timeout {
    
    static let secondsForRequest = 30.0 // secs
    static let secondsForResource = 30.0 // secs
}

class NetworkManager: SessionManager {
    
    private let reachabilityManager: NetworkReachabilityManager?
    static var successCodes = 200...300
    
    private class func defaultConfiguration() -> URLSessionConfiguration {
        
        let additionalHeaders = ["Content-Type": "application/json; charset=utf-8", "Cache-Control": "no-cache"]
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = Timeout.secondsForRequest
        sessionConfig.timeoutIntervalForResource = Timeout.secondsForResource
        sessionConfig.httpAdditionalHeaders = additionalHeaders
        
        return sessionConfig
    }
    
    // MARK: - Init
    init() {
        
        reachabilityManager = NetworkReachabilityManager()
        
        super.init(configuration: NetworkManager.defaultConfiguration())
    }
    
}
