//
//  FirstViewModelTest.swift
//  RouteTestTests
//
//  Created by Nykolas Mayko Maia Barbosa on 07/10/21.
//

import XCTest
@testable import ModularFeatureArchitecture

class FirstViewModelTest: XCTestCase {
    func test_getBusinessProperty_returnsOne() throws {
        XCTAssertEqual(makeSUT().getBusinessProperty(), "One - Mock")
    }
    
    // MARK: Helpers
    
    func makeSUT() -> FirstViewModel {
        let businessModel = SampleFeatureBusinessModel(repository: SampleFeatureApiMock())
        
        return FirstViewModel(useCase: businessModel, analytics: businessModel)
    }
}
