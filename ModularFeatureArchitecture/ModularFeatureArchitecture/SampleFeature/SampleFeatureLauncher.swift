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
    var isMockEnabled: Bool { get set }
    
    func start(delegate: SampleFeatureDelegate?) -> UIViewController
    func start(with deeplink: String, delegate: SampleFeatureDelegate?) -> UIViewController
    func getViewController(_ controller: SampleFeatureController) -> UIViewController
}

public enum SampleFeatureController {
    case first(useCase: FirstBusinessModelProtocol, analytics: FirstAnalyticsProtocol, flowDelegate: FirstViewControllerFlowDelegate)
    case second(useCase: SecondBusinessModelProtocol, analytics: SecondAnalyticsProtocol, flowDelegate: SecondViewControllerFlowDelegate)
    case third(useCase: ThirdBusinessModelProtocol, analytics: ThirdAnalyticsProtocol, flowDelegate: ThirdViewControllerFlowDelegate, someProperty: String)
    case fourth(useCase: FourthBusinessModelProtocol, analytics: FourthAnalyticsProtocol, flowDelegate: FourthViewControllerFlowDelegate)
}

public protocol SampleFeatureDelegate: AnyObject {
    func didFinish(in viewController: UIViewController)
}

public class SampleFeatureLauncher: SampleFeatureLauncherProtocol {
    public var defaultBusinessModel: SampleFeatureUseCaseProtocol & SampleFeatureAnalyticsProtocol
    public var defaultFactory: SampleFeatureViewControllerFactoryProtocol
    public var mainFlow: SampleFeatureFlowProtocol
    public var isMockEnabled: Bool {
        didSet {
            defaultBusinessModel = SampleFeatureBusinessModel(repository: isMockEnabled ? SampleFeatureApiMock() : SampleFeatureApi())
        }
    }
    
    public init(isMockEnabled: Bool = false) {
        self.defaultBusinessModel = SampleFeatureBusinessModel(repository: isMockEnabled ? SampleFeatureApiMock() : SampleFeatureApi())
        self.defaultFactory = SampleFeatureViewControllerFactory()
        self.mainFlow = SampleFeatureFlow(factory: defaultFactory)
        self.isMockEnabled = isMockEnabled
    }
    
    public func start(delegate: SampleFeatureDelegate? = nil) -> UIViewController {
        mainFlow.featureDelegate = delegate
        
        return mainFlow.start(useCase: defaultBusinessModel, analytics: defaultBusinessModel)
    }
    
    public func start(with deeplink: String, delegate: SampleFeatureDelegate? = nil) -> UIViewController {
        guard let deeplink = Deeplink(rawValue: deeplink) else { return UIViewController() }
        mainFlow.featureDelegate = delegate
        
        return getViewController(deeplink.getContoller(with: defaultBusinessModel, flowDelegate: mainFlow))
    }
    
    public func getViewController(_ controller: SampleFeatureController) -> UIViewController {
        switch controller {
        case .first(let businessModel, let analytics, let flowDelegate):
            let controller = UIViewController.instantiateVC(ofType: FirstViewController.self)!
            controller.viewModel = FirstViewModel(useCase: businessModel, analytics: analytics)
            controller.flowDelegate = flowDelegate
            
            return controller
            
        case .second(let businessModel, let analytics, let flowDelegate):
            let controller = UIViewController.instantiateVC(ofType: SecondViewController.self)!
            controller.viewModel = SecondViewModel(useCase: businessModel, analytics: analytics)
            controller.flowDelegate = flowDelegate
            
            return controller
            
        case .third(let businessModel, let analytics, let flowDelegate, let someProperty):
            let controller = UIViewController.instantiateVC(ofType: ThirdViewController.self)!
            controller.viewModel = ThirdViewModel(useCase: businessModel, analytics: analytics, someViewModelProperty: someProperty)
            controller.flowDelegate = flowDelegate

            return controller
            
        case.fourth(let businessModel, let analytics, let flowDelegate):
            let controller = UIViewController.instantiateVC(ofType: FourthViewController.self)!
            controller.viewModel = FourthViewModel(useCase: businessModel, analytics: analytics)
            controller.flowDelegate = flowDelegate

            return controller
        }
    }
}

enum Deeplink: String {
    case goToFirst = "app://sample-feature/first"
    case goToSecond = "app://sample-feature/second"
    case goToThird = "app://sample-feature/third?someProperty=123421"
    
    func getContoller(with businessModel: SampleFeatureUseCaseProtocol & SampleFeatureAnalyticsProtocol, flowDelegate: SampleFeatureFlowProtocol) -> SampleFeatureController {
        switch self {
        case .goToFirst:
            return .first(useCase: businessModel, analytics: businessModel, flowDelegate: flowDelegate as! FirstViewControllerFlowDelegate)

        case .goToSecond:
            return .second(useCase: businessModel, analytics: businessModel, flowDelegate: flowDelegate as! SecondViewControllerFlowDelegate)

        case .goToThird:
            let urlComponents = URLComponents(string: self.rawValue)
            let queryItem = urlComponents?.queryItems?.first?.value ?? ""
            return .third(useCase: businessModel, analytics: businessModel, flowDelegate: flowDelegate as! ThirdViewControllerFlowDelegate, someProperty: queryItem)
        }
    }
}
