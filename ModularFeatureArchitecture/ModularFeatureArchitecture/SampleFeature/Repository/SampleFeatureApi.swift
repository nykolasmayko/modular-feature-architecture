//
//  SampleFeatureApi.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 18/10/21.
//

import Foundation

class SampleFeatureApi: SampleFeatureRepositoryProtocol {
    let network: String
    
    init(network: String) {
        self.network = network
    }
    
    func getSomeFirstProperty() -> String {
        return "One"
    }
    
    func getSomeSecondProperty() -> String {
        return "Two"
    }
    
    func getSomeThirdProperty() -> String {
        return "Three"
    }
    
    func getSomeFourthProperty() -> String {
        return "Four"
    }
}
