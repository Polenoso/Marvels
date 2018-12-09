//
//  SeriesWorkerTests.swift
//  marvelsTests
//
//  Created by Aitor Pagán on 07/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import XCTest
@testable import marvels

class SeriesMockStore: SeriesStore {
    
    private(set) var fetchCalled = false
    var shouldReturnError = false
    
    private(set) var series: [Serie]
    
    init() {
        let path = (Bundle(for: type(of: self)).resourcePath ?? "") + "/seriesExample.json"
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            series = try JSONDecoder().decode([Serie].self, from: data)
        } catch {
            series = []
        }
    }
    
    func fetch(query: String?, offset: Int, completion: @escaping ([Serie]?, Error?) -> ()) {
        fetchCalled = true
        if (shouldReturnError) {
            completion(nil, NetworkError.request("error"))
            return
        }
        
        completion(series,nil)
    }
}

class SeriesWorkerTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchSeriesWithoutCacheShouldCallStoreToFetchSeries() {
        //Given
        let seriesMockStore = SeriesMockStore()
        let worker = SeriesWorker(with: seriesMockStore)
        worker.cleanCache()
        let expectation = self.expectation(description: "ExpectSeries")
        
        //When
        worker.fetchSeries(with: "", offset: 0, minCount: 10) { (_, _) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
        
        //Then
        XCTAssertTrue(seriesMockStore.fetchCalled, "Fetching series without cache should call store to fetch series")
    }
    
    func testFetchSeriesWithUncompletedCacheShouldCallStoreToFetchSeries() {
        //Given
        let seriesMockStore = SeriesMockStore()
        let worker = SeriesWorker(with: seriesMockStore)
        SeriesWorker.seriesCache = Set<Serie>.init(seriesMockStore.series[1...10])
        let expectation = self.expectation(description: "ExpectMoreSeries")
        
        //When
        worker.fetchSeries(with: "", offset: 0, minCount: 20) { (_, _) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
        
        //Then
        XCTAssertTrue(seriesMockStore.fetchCalled, "Fetching series with uncompleted cache call store to fetch more series")
    }
    
    func testFetchSeriesWithOffsetGreaterThanCacheShouldCallStoreToFetchSeries() {
        //Given
        let seriesMockStore = SeriesMockStore()
        let worker = SeriesWorker(with: seriesMockStore)
        SeriesWorker.seriesCache = Set<Serie>.init(seriesMockStore.series)
        let expectation = self.expectation(description: "ExpectNoCacheSeries")
        
        //When
        worker.fetchSeries(with: "", offset: 20, minCount: 20) { (_, _) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
        
        //Then
        XCTAssertTrue(seriesMockStore.fetchCalled, "Fetching series with greater offset call store to fetch more series")
    }
    
}
