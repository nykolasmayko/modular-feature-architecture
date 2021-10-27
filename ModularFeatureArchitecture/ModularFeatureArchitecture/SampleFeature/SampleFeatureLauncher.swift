//
//  SampleFeatureLauncher.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 29/09/21.
//

import UIKit

public protocol SampleFeatureLauncherProtocol {
    var defaultBusinessModel: SampleFeatureBusinessModelProtocol { get }
    var defaultFactory: SampleFeatureViewControllerFactoryProtocol { get }
    var mainFlow: SampleFeatureFlowProtocol { get }
    var isMockEnabled: Bool { get set }
    
    func start(delegate: SampleFeatureDelegate?) -> UIViewController
    func start(with deeplink: String, delegate: SampleFeatureDelegate?) -> UIViewController
    func getViewController(_ controller: SampleFeatureController) -> UIViewController
}

public enum SampleFeatureController {
    case first(businessModel: FirstBusinessModelProtocol, flowDelegate: FirstViewControllerFlowDelegate)
    case second(businessModel: SecondBusinessModelProtocol, flowDelegate: SecondViewControllerFlowDelegate)
    case third(businessModel: ThirdBusinessModelProtocol, flowDelegate: ThirdViewControllerFlowDelegate, someProperty: String)
    case fourth(businessModel: FourthBusinessModelProtocol, flowDelegate: FourthViewControllerFlowDelegate)
}

public protocol SampleFeatureDelegate: AnyObject {
    func didFinish(in viewController: UIViewController)
}

public class SampleFeatureLauncher: SampleFeatureLauncherProtocol {
    public var defaultBusinessModel: SampleFeatureBusinessModelProtocol
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
        
        return mainFlow.start(businessModel: defaultBusinessModel)
    }
    
    public func start(with deeplink: String, delegate: SampleFeatureDelegate? = nil) -> UIViewController {
        guard let deeplink = Deeplink(rawValue: deeplink) else { return UIViewController() }
        mainFlow.featureDelegate = delegate
        
        return getViewController(deeplink.getContoller(with: defaultBusinessModel, flowDelegate: mainFlow))
    }
    
    public func getViewController(_ controller: SampleFeatureController) -> UIViewController {
        switch controller {
        case .first(let businessModel, let flowDelegate):
            let controller = UIViewController.instantiateVC(ofType: FirstViewController.self)!
            controller.viewModel = FirstViewModel(businessModel: businessModel)
            controller.flowDelegate = flowDelegate
            
            return controller
            
        case .second(let businessModel, let flowDelegate):
            let controller = UIViewController.instantiateVC(ofType: SecondViewController.self)!
            controller.viewModel = SecondViewModel(businessModel: businessModel)
            controller.flowDelegate = flowDelegate
            
            return controller
            
        case .third(let businessModel, let flowDelegate, let someProperty):
            let controller = UIViewController.instantiateVC(ofType: ThirdViewController.self)!
            controller.viewModel = ThirdViewModel(businessModel: businessModel, someViewModelProperty: someProperty)
            controller.flowDelegate = flowDelegate

            return controller
            
        case.fourth(let businessModel, let flowDelegate):
            let controller = UIViewController.instantiateVC(ofType: FourthViewController.self)!
            controller.viewModel = FourthViewModel(businessModel: businessModel)
            controller.flowDelegate = flowDelegate

            return controller
        }
    }
}

enum Deeplink: String {
    case goToFirst = "app://sample-feature/first"
    case goToSecond = "app://sample-feature/second"
    case goToThird = "app://sample-feature/third?someProperty=123421"
    
    func getContoller(with businessModel: SampleFeatureBusinessModelProtocol, flowDelegate: SampleFeatureFlowProtocol) -> SampleFeatureController {
        switch self {
        case .goToFirst:
            return .first(businessModel: businessModel, flowDelegate: flowDelegate as! FirstViewControllerFlowDelegate)

        case .goToSecond:
            return .second(businessModel: businessModel, flowDelegate: flowDelegate as! SecondViewControllerFlowDelegate)

        case .goToThird:
            let urlComponents = URLComponents(string: self.rawValue)
            let queryItem = urlComponents?.queryItems?.first?.value ?? ""
            return .third(businessModel: businessModel, flowDelegate: flowDelegate as! ThirdViewControllerFlowDelegate, someProperty: queryItem)
        }
    }
}
