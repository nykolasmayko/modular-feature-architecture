//
//  SampleFeatureLauncher.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 29/09/21.
//

import UIKit

public protocol SampleFeatureLauncherProtocol {
    var defaultBusinessModel: SampleFeatureUseCaseProtocol & SampleFeatureAnalyticsProtocol { get }
    var defaultFactory: SampleFeatureViewControllerFactoryProtocol { get }
    var mainFlow: SampleFeatureFlowProtocol { get }
    
    func start(delegate: SampleFeatureDelegate?) -> UIViewController
    func start(with deeplink: String, delegate: SampleFeatureDelegate?) -> UIViewController
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
    
    static func fromDeeplink(_ deeplink: Deeplink, with businessModel: SampleFeatureUseCaseProtocol & SampleFeatureAnalyticsProtocol, flowDelegate: SampleFeatureFlowProtocol) -> SampleFeatureController {
        switch deeplink {
        case .first:
            return .first(useCase: businessModel, analytics: businessModel, flowDelegate: flowDelegate as! FirstViewControllerFlowDelegate)
            
        case .second:
            return .second(useCase: businessModel, analytics: businessModel, flowDelegate: flowDelegate as! SecondViewControllerFlowDelegate)
            
        case .third:
            let urlComponents = URLComponents(string: deeplink.rawValue)
            let queryItem = urlComponents?.queryItems?.first?.value ?? ""
            return .third(useCase: businessModel, analytics: businessModel, flowDelegate: flowDelegate as! ThirdViewControllerFlowDelegate, someProperty: queryItem)
        }
    }
}

public protocol SampleFeatureDelegate: AnyObject {
    func didFinish(in viewController: UIViewController)
}

public class SampleFeatureLauncher: SampleFeatureLauncherProtocol {
    public var defaultBusinessModel: SampleFeatureUseCaseProtocol & SampleFeatureAnalyticsProtocol
    public var defaultFactory: SampleFeatureViewControllerFactoryProtocol
    public var mainFlow: SampleFeatureFlowProtocol
    
    public init(network: String, analytics: String, isMockEnabled: Bool = false) {
        self.defaultBusinessModel = SampleFeatureBusinessModel(repository: isMockEnabled ? SampleFeatureApiMock() : SampleFeatureApi(network: network), analytics: analytics)
        self.defaultFactory = SampleFeatureViewControllerFactory()
        self.mainFlow = SampleFeatureFlow(factory: defaultFactory)
    }
    
    public func start(delegate: SampleFeatureDelegate? = nil) -> UIViewController {
        mainFlow.featureDelegate = delegate
        
        return mainFlow.start(useCase: defaultBusinessModel, analytics: defaultBusinessModel)
    }
    
    public func start(with deeplink: String, delegate: SampleFeatureDelegate? = nil) -> UIViewController {
        guard let deeplink = Deeplink(rawValue: deeplink) else { return UIViewController() }
        mainFlow.featureDelegate = delegate
        
        return get(SampleFeatureController.fromDeeplink(deeplink, with: defaultBusinessModel, flowDelegate: mainFlow))
    }
    
    public func get(_ controller: SampleFeatureController) -> UIViewController {
        switch controller {
        case .first(let businessModel, let analytics, let flowDelegate):
            return defaultFactory.createFirstViewController(useCase: businessModel, analytics: analytics, and: flowDelegate)
            
        case .second(let businessModel, let analytics, let flowDelegate):
            return defaultFactory.createSecondViewController(useCase: businessModel, analytics: analytics, and: flowDelegate)
            
        case .third(let businessModel, let analytics, let flowDelegate, let someProperty):
            return defaultFactory.createThirdViewController(useCase: businessModel, analytics: analytics, flowDelegate: flowDelegate, and: someProperty)
            
        case.fourth(let businessModel, let analytics, let flowDelegate):
            return defaultFactory.createFourthViewController(useCase: businessModel, analytics: analytics, and: flowDelegate)
        }
    }
}
