//
//  BusinessModelProtocol.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 28/09/21.
//

public protocol SampleFeatureBusinessModelProtocol: FirstBusinessModelProtocol, SecondBusinessModelProtocol, ThirdBusinessModelProtocol, FourthBusinessModelProtocol {
    var repository: SampleFeatureRepositoryProtocol { get }
}

public protocol FirstBusinessModelProtocol {
    var someFirstBusinessProperty: String { get }
}

public protocol SecondBusinessModelProtocol {
    var someSecondBusinessProperty: String { get }
}

public protocol ThirdBusinessModelProtocol {
    var someThirdBusinessProperty: String { get }
}

public protocol FourthBusinessModelProtocol {
    var someFourthBusinessProperty: String { get }
}
