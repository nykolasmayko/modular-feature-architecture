//
//  SampleFeatureLauncher.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 29/09/21.
//

import UIKit

public protocol SampleFeatureLauncherProtocol {
    var businessModel: SampleFeatureUseCaseProtocol & SampleFeatureAnalyticsProtocol { get }
    var factory: SampleFeatureViewControllerFactoryProtocol { get }
    var mainFlow: SampleFeatureFlowProtocol { get }
    
    func start(delegate: SampleFeatureDelegate?) -> UIViewController
    func start(deeplink: String, delegate: SampleFeatureDelegate?) -> UIViewController
    func get(_ controller: SampleFeatureController) -> UIViewController
}

enum Deeplink: String {
    case first = "app://sample-feature/first"
    case second = "app://sample-feature/second"
    case third = "app://sample-feature/third?someProperty=123421"
}

public enum SampleFeatureController {
    case first(useCase: FirstBusinessModelProtocol, analytics: FirstAnalyticsProtocol, flowDelegate: FirstViewControllerFlowDelegate)
    case second(useCase: SecondBusinessModelProtocol, analytics: SecondAnalyticsProtocol, flowDelegate: SecondViewControllerFlowDelegate)
    case third(useCase: ThirdBusinessModelProtocol, analytics: ThirdAnalyticsProtocol, flowDelegate: ThirdViewControllerFlowDelegate, someProperty: String)
    case fourth(useCase: FourthBusinessModelProtocol, analytics: FourthAnalyticsProtocol, flowDelegate: FourthViewControllerFlowDelegate)
    
    static func from(_ deeplink: Deeplink, with businessModel: SampleFeatureUseCaseProtocol, analytics: SampleFeatureAnalyticsProtocol, andFlowDelegate flowDelegate: SampleFeatureFlowProtocol) -> SampleFeatureController {
        switch deeplink {
        case .first:
            return .first(useCase: businessModel, analytics: analytics, flowDelegate: flowDelegate as! FirstViewControllerFlowDelegate)
            
        case .second:
            return .second(useCase: businessModel, analytics: analytics, flowDelegate: flowDelegate as! SecondViewControllerFlowDelegate)
            
        case .third:
            let urlComponents = URLComponents(string: deeplink.rawValue)
            let queryItem = urlComponents?.queryItems?.first?.value ?? ""
            return .third(useCase: businessModel, analytics: analytics, flowDelegate: flowDelegate as! ThirdViewControllerFlowDelegate, someProperty: queryItem)
        }
    }
}

public protocol SampleFeatureDelegate: AnyObject {
    func didFinish(in viewController: UIViewController)
}

public class SampleFeatureLauncher: SampleFeatureLauncherProtocol {
    public var businessModel: SampleFeatureUseCaseProtocol & SampleFeatureAnalyticsProtocol
    public var factory: SampleFeatureViewControllerFactoryProtocol
    public var mainFlow: SampleFeatureFlowProtocol
    
    public init(network: String, analytics: String, isMockEnabled: Bool = false) {
        self.businessModel = SampleFeatureBusinessModel(repository: isMockEnabled ? SampleFeatureApiMock() : SampleFeatureApi(network: network), analytics: analytics)
        self.factory = SampleFeatureViewControllerFactory()
        self.mainFlow = SampleFeatureFlow(factory: factory)
    }
    
    public func start(delegate: SampleFeatureDelegate? = nil) -> UIViewController {
        mainFlow.featureDelegate = delegate
        
        return mainFlow.start(useCase: businessModel, analytics: businessModel)
    }
    
    public func start(deeplink: String, delegate: SampleFeatureDelegate? = nil) -> UIViewController {
        guard let deeplink = Deeplink(rawValue: deeplink) else { return UIViewController() }
        mainFlow.featureDelegate = delegate
        
        return get(SampleFeatureController.from(deeplink, with: businessModel, analytics: businessModel, andFlowDelegate: mainFlow))
    }
    
    public func get(_ controller: SampleFeatureController) -> UIViewController {
        switch controller {
        case .first(let businessModel, let analytics, let flowDelegate):
            return factory.makeFirstViewController(useCase: businessModel, analytics: analytics, and: flowDelegate)
            
        case .second(let businessModel, let analytics, let flowDelegate):
            return factory.makeSecondViewController(useCase: businessModel, analytics: analytics, and: flowDelegate)
            
        case .third(let businessModel, let analytics, let flowDelegate, let someProperty):
            return factory.makeThirdViewController(useCase: businessModel, analytics: analytics, flowDelegate: flowDelegate, and: someProperty)
            
        case.fourth(let businessModel, let analytics, let flowDelegate):
            return factory.makeFourthViewController(useCase: businessModel, analytics: analytics, and: flowDelegate)
        }
    }
}
