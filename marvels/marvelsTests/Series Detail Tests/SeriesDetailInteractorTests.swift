//
//  SeriesDetailInteractorTests.swift
//  marvelsTests
//
//  Created by Aitor Pagán on 09/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import XCTest
@testable import marvels

class SeriesDetailPresenterSpy: SeriesDetailOutputWrapper {
    
    private(set) var presentDetailCalled = false
    func presentDetail(response: SeriesDetailModels.GetDetail.Response) {
        presentDetailCalled = true
    }
}

class SeriesDetailInteractorTests: XCTestCase {
    
    var interactor: SeriesDetailInteractor!

    override func setUp() {
        interactor = SeriesDetailInteractor()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchDetailShouldCallPresenterToPresentDetail() {
        //Given
        let outputSpy = SeriesDetailPresenterSpy()
        interactor.serie = Serie.init(id: 0, title: "", description: "", startYear: nil, endYear: nil, rating: nil, type: nil, thumbnail: nil, modified: nil)
        interactor.outputWrapper = outputSpy
        
        //When
        interactor.fetchDetail(request: SeriesDetailModels.GetDetail.Request())
        
        //Then
        XCTAssertTrue(outputSpy.presentDetailCalled, "Fetch Detail should call presenter to present detail")
    }

}
