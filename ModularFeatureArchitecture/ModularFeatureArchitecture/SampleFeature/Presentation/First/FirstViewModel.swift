//
//  FirstViewModel.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 27/09/21.
//

import Foundation

public protocol FirstBusinessModelProtocol {
    var someFirstBusinessProperty: String { get }
}

public protocol FirstAnalyticsProtocol {
    func onFirstContinueButtonClick()
}

public protocol FirstViewModelProtocol: BaseViewModelProtocol {
    func getBusinessProperty() -> String
    func onContinueButtonClick() -> Void
}

class FirstViewModel: BaseViewModel<FirstBusinessModelProtocol, FirstAnalyticsProtocol>, FirstViewModelProtocol {
    func onContinueButtonClick() {
        analytics?.onFirstContinueButtonClick()
    }
    
    func getBusinessProperty() -> String {
        return useCase?.someFirstBusinessProperty ?? ""
    }
}
