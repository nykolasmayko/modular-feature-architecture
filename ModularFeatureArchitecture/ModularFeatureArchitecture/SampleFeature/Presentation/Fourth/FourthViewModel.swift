//
//  FourthViewModel.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 27/09/21.
//

import Foundation

public protocol FourthBusinessModelProtocol {
    var someFourthBusinessProperty: String { get }
}

public protocol FourthAnalyticsProtocol {}

public protocol FouthViewModelProtocol: BaseViewModelProtocol {
    func getBusinessProperty() -> String
}

class FourthViewModel: BaseViewModel<FourthBusinessModelProtocol, FourthAnalyticsProtocol>, FouthViewModelProtocol {
    func getBusinessProperty() -> String {
        return useCase?.someFourthBusinessProperty ?? ""
    }
}
