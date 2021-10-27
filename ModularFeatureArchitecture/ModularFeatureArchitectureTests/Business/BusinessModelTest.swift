//
//  BusinessModelTest.swift
//  ModularFeatureArchitectureTests
//
//  Created by Nykolas Mayko Maia Barbosa on 08/10/21.
//

import XCTest
@testable import ModularFeatureArchitecture

class BusinessModelTest: XCTestCase {
    func test_someFirstBusinessProperty_returnsOne() throws {
        XCTAssertEqual(makeSUT().someFirstBusinessProperty, "One - Mock")
    }
    
    func test_someSecondBusinessProperty_returnsTwo() throws {
        XCTAssertEqual(makeSUT().someSecondBusinessProperty, "Two - Mock")
    }
    
    func test_someThirdBusinessProperty_returnsThree() throws {
        XCTAssertEqual(makeSUT().someThirdBusinessProperty, "Three - Mock")
    }
    
    func test_someFourthBusinessProperty_returnsFour() throws {
        XCTAssertEqual(makeSUT().someFourthBusinessProperty, "Four - Mock")
    }

    
    // MARK: Helpers
    
    func makeSUT() -> SampleFeatureBusinessModel {
        return SampleFeatureBusinessModel(repository: SampleFeatureApiMock(), analytics: "Adicionar Mock do Módulo Estruturante de Analytics")
    }
}
