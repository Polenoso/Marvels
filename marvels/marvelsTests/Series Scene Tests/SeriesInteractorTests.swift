//
//  SeriesInteractorTests.swift
//  marvelsTests
//
//  Created by Aitor Pagán on 09/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import XCTest
@testable import marvels

class SeriesWorkerSpy: SeriesWorkerProtocol {
    var returnError = false
    func cleanCache() {
        
    }
    
    private(set) var fetchSeriesCalled = false
    func fetchSeries(with query: String?, offset: Int, minCount: Int, completion: @escaping (SeriesCompletionBlock)) {
        fetchSeriesCalled = true
        if(returnError) {
            completion(nil, Errors.timeout(""))
        } else {
            completion([],nil)
        }
    }
}

class SeriesPresenterOutputSpy: SeriesWrapperProtocol {
    private(set) var presentSeriesCalled = false
    func presentSeries(response: SeriesModels.GetSeries.Response) {
        presentSeriesCalled = true
    }
    
    private(set) var presentLoadingCalled = false
    func presentLoading(response: SeriesModels.Loading.PresentLoading) {
        presentLoadingCalled = true
    }
    
    private(set) var presentErrorCalled = false
    func presentError(response: SeriesModels.Error.PresentError) {
        presentErrorCalled = true
    }
    
    
}

class SeriesInteractorTests: XCTestCase {
    
    var interactor: SeriesInteractor!

    override func setUp() {
        interactor = SeriesInteractor()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchSeriesWithEmptySeriesWithSuccessShouldCallPresenterToPresentSeries() {
        //Given
        interactor.series = []
        interactor.service = SeriesWorkerSpy()
        let outputSpy = SeriesPresenterOutputSpy()
        interactor.outputWrapper = outputSpy
        
        //When
        interactor.fetchSeries(request: SeriesModels.GetSeries.Request(query: "", maxIndex: 0, forceRefresh: false))
        
        //Then
        XCTAssertTrue(outputSpy.presentSeriesCalled, "Fetching series with success should call presenter to present series")
    }
    
    func testFetchSeriesWithForceShouldCallPresenterToPresentLoading() {
        //Given
        interactor.service = SeriesWorkerSpy()
        let outputSpy = SeriesPresenterOutputSpy()
        interactor.outputWrapper = outputSpy
        
        //When
        interactor.fetchSeries(request: SeriesModels.GetSeries.Request(query: "", maxIndex: 0, forceRefresh: true))
        
        //Then
        XCTAssertTrue(outputSpy.presentLoadingCalled, "Fetching series with force should call presenter to present loading")
    }
    
    func testFetchSeriesWithErrorShouldCallPresenterToPresentError() {
        //Given
        let workerSpy = SeriesWorkerSpy()
        workerSpy.returnError = true
        interactor.service = workerSpy
        let outputSpy = SeriesPresenterOutputSpy()
        interactor.outputWrapper = outputSpy
        
        //When
        interactor.fetchSeries(request: SeriesModels.GetSeries.Request(query: "", maxIndex: 0, forceRefresh: false))
        
        //Then
        XCTAssertTrue(outputSpy.presentErrorCalled, "Fetching series with error should call presenter to present error")
    }

}
