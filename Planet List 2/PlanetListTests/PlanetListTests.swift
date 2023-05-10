//
//  JPMC_MCoETests.swift
//  JPMC MCoETests
//
//  Created by Stephen Chase on 09/05/2023.
//

import XCTest
@testable import Planet_List

final class PlanetListTests: XCTestCase {

    var sut: PlanetListViewModel!
    var mockSession: NetworkSessionMock!
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockSession = NetworkSessionMock()
        mockSession.data = MockPlanetData().getPlanetDataFromFile()
        sut = PlanetListViewModel(nwHandler: NetworkHandler(session: mockSession))
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testGetPlanetListFromAPI() async {
        try? await sut.getPlanetListFromAPI()
        sut.getPlanetListFromLocal()
        XCTAssertEqual(sut.planetList.count, 10)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
