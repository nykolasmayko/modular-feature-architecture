//
//  SampleFeatureBusinessModel+Analytics.swift
//  ModularFeatureArchitecture
//
//  Created by Nykolas Mayko Maia Barbosa on 27/10/21.
//

import Foundation

public protocol SampleFeatureAnalyticsProtocol: FirstAnalyticsProtocol, SecondAnalyticsProtocol, ThirdAnalyticsProtocol, FourthAnalyticsProtocol {
    var analytics: String { get }
}

extension SampleFeatureBusinessModel: SampleFeatureAnalyticsProtocol {
    func onFirstViewContinueButtonClick() {
        print("Needs to call the Technical Analytics Module (i.e. analytics.track())")
    }
}
