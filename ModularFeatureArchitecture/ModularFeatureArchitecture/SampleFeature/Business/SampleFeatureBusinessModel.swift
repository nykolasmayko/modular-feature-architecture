//
//  BusinessModel.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 27/09/21.
//

import Foundation

class SampleFeatureBusinessModel: SampleFeatureBusinessModelProtocol {
    var repository: SampleFeatureRepositoryProtocol
    
    public var someFirstBusinessProperty: String {
        return repository.getSomeFirstProperty()
    }
    public var someSecondBusinessProperty: String{
        return repository.getSomeSecondProperty()
    }
    public var someThirdBusinessProperty: String{
        return repository.getSomeThirdProperty()
    }
    public var someFourthBusinessProperty: String{
        return repository.getSomeFourthProperty()
    }
    
    init(repository: SampleFeatureRepositoryProtocol) {
        self.repository = repository
    }
}



