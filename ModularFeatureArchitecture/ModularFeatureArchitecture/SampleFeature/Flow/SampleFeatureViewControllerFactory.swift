//
//  SampleFeatureRouter.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 11/10/21.
//

import Foundation
import UIKit

public protocol SampleFeatureViewControllerFactoryProtocol {
    func createFirstViewController<U, A, F>(from viewModel: BaseViewModel<U, A>?, and flowDelegate: F?) -> UIViewController
    func createSecondViewController<U, A, F>(from viewModel: BaseViewModel<U, A>?, and flowDelegate: F?) -> UIViewController
    func createThirdViewController<U, A, F>(from viewModel: BaseViewModel<U, A>?, flowDelegate: F?, someProperty: String) -> UIViewController
    func createFourthViewController<U, A, F>(from viewModel: BaseViewModel<U, A>?, and flowDelegate: F?) -> UIViewController
}

class SampleFeatureViewControllerFactory: BaseViewControllerFactory, SampleFeatureViewControllerFactoryProtocol {
    func createFirstViewController<U, A, F>(from viewModel: BaseViewModel<U, A>?, and flowDelegate: F?) -> UIViewController {
        guard let (useCase, analytics) = getUseCaseAndAnalytics(from: viewModel) as? (FirstBusinessModelProtocol, FirstAnalyticsProtocol) else { return UIViewController() }
                
        guard let viewController: FirstViewController = getViewControllerFromStoryboard() else { return UIViewController() }
        viewController.viewModel = FirstViewModel(useCase: useCase, analytics: analytics)
        viewController.flowDelegate = flowDelegate as? FirstViewControllerFlowDelegate
        
        return viewController
    }
    
    func createSecondViewController<U, A, F>(from viewModel: BaseViewModel<U, A>?, and flowDelegate: F?) -> UIViewController {
        guard let (useCase, analytics) = getUseCaseAndAnalytics(from: viewModel) as? (SecondBusinessModelProtocol, SecondAnalyticsProtocol) else { return UIViewController() }
        
        guard let viewController: SecondViewController = getViewControllerFromStoryboard() else { return UIViewController() }
        viewController.viewModel = SecondViewModel(useCase: useCase, analytics: analytics)
        viewController.flowDelegate = flowDelegate as? SecondViewControllerFlowDelegate
        
        return viewController
    }
    
    func createThirdViewController<U, A, F>(from viewModel: BaseViewModel<U, A>?, flowDelegate: F?, someProperty: String) -> UIViewController {
        guard let (useCase, analytics) = getUseCaseAndAnalytics(from: viewModel) as? (ThirdBusinessModelProtocol, ThirdAnalyticsProtocol) else { return UIViewController() }
        
        guard let viewController: ThirdViewController = getViewControllerFromStoryboard() else { return UIViewController() }
        viewController.viewModel = ThirdViewModel(useCase: useCase, analytics: analytics, someViewModelProperty: someProperty)
        viewController.flowDelegate = flowDelegate as? ThirdViewControllerFlowDelegate
        
        return viewController
    }
    
    func createFourthViewController<U, A, F>(from viewModel: BaseViewModel<U, A>?, and flowDelegate: F?) -> UIViewController {
        guard let (useCase, analytics) = getUseCaseAndAnalytics(from: viewModel) as? (FourthBusinessModelProtocol, FourthAnalyticsProtocol) else { return UIViewController() }
        
        guard let viewController: FourthViewController = getViewControllerFromStoryboard() else { return UIViewController() }
        viewController.viewModel = FourthViewModel(useCase: useCase, analytics: analytics)
        viewController.flowDelegate = flowDelegate as? FourthViewControllerFlowDelegate
        
        return viewController
    }
}
