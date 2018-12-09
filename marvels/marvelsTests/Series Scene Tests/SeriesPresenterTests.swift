//
//  SeriesPresenterTests.swift
//  marvelsTests
//
//  Created by Aitor Pagán on 09/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import XCTest
@testable import marvels

class SeriesViewOutputSpy: SeriesOutputProtocol {
    private(set) var displaySelectedSerieCalled = false
    func displaySelectedSerie(viewModel: SeriesModels.SelectSerie.ViewModel) {
        displaySelectedSerieCalled = true
    }
    
    private(set) var displaySeriesCalled = false
    func displaySeries(viewModel: SeriesModels.GetSeries.ViewModel) {
        displaySeriesCalled = true
    }
    
    private(set) var displayLoadingCalled = false
    func displayLoading(viewModel: SeriesModels.Loading.DisplayLoading) {
        displayLoadingCalled = true
    }
    
    private(set) var displayErrorCalled = false
    func displayError(viewModel: SeriesModels.Error.DisplayError) {
        displayErrorCalled = true
    }
    
    
}

class SeriesPresenterTests: XCTestCase {

    var presenter: SeriesPresenter!
    override func setUp() {
        presenter = SeriesPresenter()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPresentSeriesShouldCallOutputDisplaySeries() {
        //Given
        let outputSpy = SeriesViewOutputSpy()
        presenter.output = outputSpy
        
        //When
        presenter.presentSeries(response: SeriesModels.GetSeries.Response.init(result: []))
        
        //Then
        XCTAssertTrue(outputSpy.displaySeriesCalled, "Presenting series should call output to display series")
    }
    
    func testPresentErrorShouldCallOutputDisplayError() {
        //Given
        let outputSpy = SeriesViewOutputSpy()
        presenter.output = outputSpy
        
        //When
        presenter.presentError(response: SeriesModels.Error.PresentError.init(error: Errors.timeout("")))
        
        //Then
        XCTAssertTrue(outputSpy.displayErrorCalled, "Presenting error should call output to display error")
    }
    
    func testPresentLoadingShouldCallOutputDisplayLoading() {
        //Given
        let outputSpy = SeriesViewOutputSpy()
        presenter.output = outputSpy
        
        //When
        presenter.presentLoading(response: SeriesModels.Loading.PresentLoading.init())
        
        //Then
        XCTAssertTrue(outputSpy.displayLoadingCalled, "Presenting loading should call output to display loading")
    }
    
    func testPresentSelectedSerieShouldCallOutputDisplaySelectedSerie() {
        //Given
        let outputSpy = SeriesViewOutputSpy()
        presenter.output = outputSpy
        
        //When
        presenter.presentSelectedSerie(response: SeriesModels.SelectSerie.Response())
        
        //Then
        XCTAssertTrue(outputSpy.displaySelectedSerieCalled, "Presenting selected serie should call output to display selected serie")
    }

}
