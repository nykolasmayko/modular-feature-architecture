//
//  SampleFeatureRouter.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 11/10/21.
//

import Foundation
import UIKit

public protocol SampleFeatureViewControllerFactoryProtocol {
    func createFirstViewController(useCase: FirstBusinessModelProtocol?, analytics: FirstAnalyticsProtocol?, and flowDelegate: FirstViewControllerFlowDelegate?) -> UIViewController
    func createSecondViewController(useCase: SecondBusinessModelProtocol?, analytics: SecondAnalyticsProtocol?, and flowDelegate: SecondViewControllerFlowDelegate?) -> UIViewController
    func createThirdViewController(useCase: ThirdBusinessModelProtocol?, analytics: ThirdAnalyticsProtocol?, flowDelegate: ThirdViewControllerFlowDelegate?, and someProperty: String) -> UIViewController
    func createFourthViewController(useCase: FourthBusinessModelProtocol?, analytics: FourthAnalyticsProtocol?, and flowDelegate: FourthViewControllerFlowDelegate?) -> UIViewController
}

class SampleFeatureViewControllerFactory: BaseViewControllerFactory, SampleFeatureViewControllerFactoryProtocol {
    func createFirstViewController(useCase: FirstBusinessModelProtocol?, analytics: FirstAnalyticsProtocol?, and flowDelegate: FirstViewControllerFlowDelegate?) -> UIViewController {                
        guard let viewController: FirstViewController = getViewControllerFromStoryboard() else { return UIViewController() }
        viewController.viewModel = FirstViewModel(useCase: useCase, analytics: analytics)
        viewController.flowDelegate = flowDelegate
        
        return viewController
    }
    
    func createSecondViewController(useCase: SecondBusinessModelProtocol?, analytics: SecondAnalyticsProtocol?, and flowDelegate: SecondViewControllerFlowDelegate?) -> UIViewController {
        guard let viewController: SecondViewController = getViewControllerFromStoryboard() else { return UIViewController() }
        viewController.viewModel = SecondViewModel(useCase: useCase, analytics: analytics)
        viewController.flowDelegate = flowDelegate
        
        return viewController
    }
    
    func createThirdViewController(useCase: ThirdBusinessModelProtocol?, analytics: ThirdAnalyticsProtocol?, flowDelegate: ThirdViewControllerFlowDelegate?, and someProperty: String) -> UIViewController {
        guard let viewController: ThirdViewController = getViewControllerFromStoryboard() else { return UIViewController() }
        viewController.viewModel = ThirdViewModel(useCase: useCase, analytics: analytics, someViewModelProperty: someProperty)
        viewController.flowDelegate = flowDelegate
        
        return viewController
    }
    
    func createFourthViewController(useCase: FourthBusinessModelProtocol?, analytics: FourthAnalyticsProtocol?, and flowDelegate: FourthViewControllerFlowDelegate?) -> UIViewController {
        guard let viewController: FourthViewController = getViewControllerFromStoryboard() else { return UIViewController() }
        viewController.viewModel = FourthViewModel(useCase: useCase, analytics: analytics)
        viewController.flowDelegate = flowDelegate
        
        return viewController
    }
}
