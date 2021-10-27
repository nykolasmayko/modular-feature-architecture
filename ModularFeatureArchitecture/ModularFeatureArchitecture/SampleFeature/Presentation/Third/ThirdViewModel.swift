//
//  ThirdViewModel.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 27/09/21.
//

import Foundation

public protocol ThirdViewModelProtocol: BaseViewModelProtocol {
    var someViewModelProperty: String { get set }
    func getBusinessProperty() -> String
}

class ThirdViewModel: BaseViewModel<ThirdBusinessModelProtocol>, ThirdViewModelProtocol {
    var someViewModelProperty: String
    
    init(businessModel: ThirdBusinessModelProtocol?, someViewModelProperty: String) {
        self.someViewModelProperty = someViewModelProperty
        super.init(businessModel: businessModel)
    }
    
    func getBusinessProperty() -> String {
        return businessModel?.someThirdBusinessProperty ?? ""
    }
}
