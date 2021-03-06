//
//  SecondViewModel.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 27/09/21.
//

import Foundation

public protocol SecondBusinessModelProtocol {
    var someSecondBusinessProperty: String { get }
}

public protocol SecondAnalyticsProtocol {}

public protocol SecondViewModelProtocol: BaseViewModelProtocol {
    func getBusinessProperty() -> String
}

class SecondViewModel: BaseViewModel<SecondBusinessModelProtocol, SecondAnalyticsProtocol>, SecondViewModelProtocol  {
    func getBusinessProperty() -> String {
        return useCase?.someSecondBusinessProperty ?? ""
    }
}
