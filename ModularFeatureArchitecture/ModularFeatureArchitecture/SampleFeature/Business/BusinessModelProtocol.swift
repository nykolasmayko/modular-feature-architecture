//
//  BusinessModelProtocol.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 28/09/21.
//

public protocol SampleFeatureUseCaseProtocol: FirstBusinessModelProtocol, SecondBusinessModelProtocol, ThirdBusinessModelProtocol, FourthBusinessModelProtocol {
    var repository: SampleFeatureRepositoryProtocol { get }
}

public protocol SampleFeatureAnalyticsProtocol: FirstAnalyticsProtocol, SecondAnalyticsProtocol, ThirdAnalyticsProtocol, FourthAnalyticsProtocol {}

public protocol FirstBusinessModelProtocol {
    var someFirstBusinessProperty: String { get }
}

public protocol FirstAnalyticsProtocol {
    func onFirstContinueButtonClick()
}

public protocol SecondBusinessModelProtocol {
    var someSecondBusinessProperty: String { get }
}

public protocol SecondAnalyticsProtocol {}

public protocol ThirdBusinessModelProtocol {
    var someThirdBusinessProperty: String { get }
}

public protocol ThirdAnalyticsProtocol {}

public protocol FourthBusinessModelProtocol {
    var someFourthBusinessProperty: String { get }
}

public protocol FourthAnalyticsProtocol {}
