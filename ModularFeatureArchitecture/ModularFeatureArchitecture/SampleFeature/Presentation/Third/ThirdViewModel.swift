//
//  ThirdViewModel.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 27/09/21.
//

import Foundation

public protocol ThirdBusinessModelProtocol {
    var someThirdBusinessProperty: String { get }
}

public protocol ThirdAnalyticsProtocol {}

public protocol ThirdViewModelProtocol: BaseViewModelProtocol {
    var someViewModelProperty: String { get set }
    func getBusinessProperty() -> String
}

class ThirdViewModel: BaseViewModel<ThirdBusinessModelProtocol, ThirdAnalyticsProtocol>, ThirdViewModelProtocol {
    var someViewModelProperty: String
    
    init(useCase: ThirdBusinessModelProtocol?, analytics: ThirdAnalyticsProtocol?, someViewModelProperty: String) {
        self.someViewModelProperty = someViewModelProperty
        super.init(useCase: useCase, analytics: analytics)
    }
    
    func getBusinessProperty() -> String {
        return useCase?.someThirdBusinessProperty ?? ""
    }
}
