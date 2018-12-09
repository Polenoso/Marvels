//
//  SeriesDetailPresenterTests.swift
//  marvelsTests
//
//  Created by Aitor Pagán on 09/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import XCTest
@testable import marvels

class SeriesDetailViewSpy: SeriesDetailOutput {
    private(set) var displayDetailCalled = true
    func displayDetail(viewModel: SeriesDetailModels.GetDetail.ViewModel) {
        displayDetailCalled = true
    }
}

class SeriesDetailPresenterTests: XCTestCase {
    
    var presenter: SeriesDetailPresenter!

    override func setUp() {
        presenter = SeriesDetailPresenter()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPresentDetailShouldCallOutputDisplayDetail() {
        //Given
        let outputSpy = SeriesDetailViewSpy()
        presenter.output = outputSpy
        
        //When
        presenter.presentDetail(response: SeriesDetailModels.GetDetail.Response.init(result: Serie.init(id: 0, title: nil, description: nil, startYear: nil, endYear: nil, rating: nil, type: nil, thumbnail: nil, modified:nil)))
        
        //Then
        XCTAssertTrue(outputSpy.displayDetailCalled, "Present detail should call output to display detail")
    }

}
