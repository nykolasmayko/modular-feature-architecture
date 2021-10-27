//
//  SampleFeatureApiMock.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 18/10/21.
//

import Foundation

class SampleFeatureApiMock: SampleFeatureRepositoryProtocol {
    func getSomeFirstProperty() -> String {
        return "One - Mock"
    }
    
    func getSomeSecondProperty() -> String {
        return "Two - Mock"
    }
    
    func getSomeThirdProperty() -> String {
        return "Three - Mock"
    }
    
    func getSomeFourthProperty() -> String {
        return "Four - Mock"
    }
}
