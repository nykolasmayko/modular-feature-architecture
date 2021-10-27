//
//  SecondViewModel.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 27/09/21.
//

import Foundation

public protocol SecondViewModelProtocol: BaseViewModelProtocol {
    func getBusinessProperty() -> String
}

class SecondViewModel: BaseViewModel<SecondBusinessModelProtocol>, SecondViewModelProtocol  {    
    func getBusinessProperty() -> String {
        return businessModel?.someSecondBusinessProperty ?? ""
    }
}
