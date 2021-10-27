//
//  BaseViewModel.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 27/09/21.
//

import Foundation

public protocol BaseViewModelProtocol {
    func getUseCase<UseCase>() -> UseCase?
    func getAnalytics<AnalyticsModel>() -> AnalyticsModel?
}

public protocol ViewModelProtocol: BaseViewModelProtocol {
    associatedtype UseCase
    associatedtype AnalyticsModel
    var useCase: UseCase? { get }
    var analytics: AnalyticsModel? { get }
}

open class BaseViewModel<U, A>: ViewModelProtocol {
    public typealias UseCase = U
    public typealias AnalyticsModel = A
    
    public var useCase: UseCase?
    public var analytics: AnalyticsModel?
    
    init(useCase: UseCase?, analytics: AnalyticsModel?) {
        self.useCase = useCase
        self.analytics = analytics
    }
    
    public func getUseCase<UseCase>() -> UseCase? {
        return useCase as? UseCase
    }
    
    public func getAnalytics<AnalyticsModel>() -> AnalyticsModel? {
        return analytics as? AnalyticsModel
    }
}
