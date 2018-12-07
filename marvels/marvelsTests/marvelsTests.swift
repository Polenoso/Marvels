//
//  marvelsTests.swift
//  marvelsTests
//
//  Created by Aitor Pagán on 06/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import XCTest
@testable import marvels

class marvelsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCallNetworkToFethcSeriesShouldReturnSeries() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let ts = Date().timeIntervalSince1970.description
        let privateKey = ""
        let publicKey = ""
        let hash = "\(ts)\(privateKey)\(publicKey)".md5Digest()
        let url = URL(string: "https://gateway.marvel.com:443/v1/public/series")
        var request = URLRequest(url:url!)
        let parameters = ["ts": ts,
                          "apikey" : publicKey,
                          "hash": hash] as [String : Any]
        request.httpMethod = "GET"
        let expectation = self.expectation(description: "wait")
        var seriesRes: [Serie]? = []
        let networkRequest = NetworkRequest.init(url: url!, parameters: parameters, headers: nil, method: .get, parsingPath: "data.results")
        Network.shared.requestData(type: [Serie].self, request: networkRequest) { (series, error) in
            seriesRes = series
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(seriesRes?.count ?? 0 > 0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
