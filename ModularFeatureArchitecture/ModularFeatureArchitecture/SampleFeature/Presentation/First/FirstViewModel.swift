//
//  FirstViewModel.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 27/09/21.
//

import Foundation

public protocol FirstViewModelProtocol: BaseViewModelProtocol {
    func getBusinessProperty() -> String
}

class FirstViewModel: BaseViewModel<FirstBusinessModelProtocol>, FirstViewModelProtocol {    
    func getBusinessProperty() -> String {
        return businessModel?.someFirstBusinessProperty ?? ""
    }
}
