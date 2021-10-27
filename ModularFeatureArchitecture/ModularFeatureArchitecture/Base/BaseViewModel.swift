//
//  BaseViewModel.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 27/09/21.
//

import Foundation

public protocol BaseViewModelProtocol {
    func getBusinessModel<BusinessModel>() -> BusinessModel?
}

public protocol ViewModelProtocol: BaseViewModelProtocol {
    associatedtype BusinessModel
    var businessModel: BusinessModel? { get }
}

open class BaseViewModel<B>: ViewModelProtocol {
    public typealias BusinessModel = B
    
    public var businessModel: BusinessModel?
    
    init(businessModel: BusinessModel?) {
        self.businessModel = businessModel
    }
    
    public func getBusinessModel<BusinessModel>() -> BusinessModel? {
        return businessModel as? BusinessModel
    }
}
