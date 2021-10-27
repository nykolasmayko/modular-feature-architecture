//
//  SampleFeatureRouter.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 11/10/21.
//

import Foundation
import UIKit

public protocol SampleFeatureViewControllerFactoryProtocol {
    func createFirstViewController<B, F>(from viewModel: BaseViewModel<B>?, and flowDelegate: F?) -> UIViewController
    func createSecondViewController<B, F>(from viewModel: BaseViewModel<B>?, and flowDelegate: F?) -> UIViewController
    func createThirdViewController<B, F>(from viewModel: BaseViewModel<B>?, flowDelegate: F?, someProperty: String) -> UIViewController
    func createFourthViewController<B, F>(from viewModel: BaseViewModel<B>?, and flowDelegate: F?) -> UIViewController
}

class SampleFeatureViewControllerFactory: BaseViewControllerFactory, SampleFeatureViewControllerFactoryProtocol {
    func createFirstViewController<B, F>(from viewModel: BaseViewModel<B>?, and flowDelegate: F?) -> UIViewController {
        guard let businessModel = getBusinessModel(from: viewModel) as? FirstBusinessModelProtocol else { return UIViewController() }
                
        guard let viewController: FirstViewController = getViewControllerFromStoryboard() else { return UIViewController() }
        viewController.viewModel = FirstViewModel(businessModel: businessModel)
        viewController.flowDelegate = flowDelegate as? FirstViewControllerFlowDelegate
        
        return viewController
    }
    
    func createSecondViewController<B, F>(from viewModel: BaseViewModel<B>?, and flowDelegate: F?) -> UIViewController {
        guard let businessModel = getBusinessModel(from: viewModel) as? SecondBusinessModelProtocol else { return UIViewController() }
        
        guard let viewController: SecondViewController = getViewControllerFromStoryboard() else { return UIViewController() }
        viewController.viewModel = SecondViewModel(businessModel: businessModel)
        viewController.flowDelegate = flowDelegate as? SecondViewControllerFlowDelegate
        
        return viewController
    }
    
    func createThirdViewController<B, F>(from viewModel: BaseViewModel<B>?, flowDelegate: F?, someProperty: String) -> UIViewController {
        guard let businessModel = getBusinessModel(from: viewModel) as? ThirdBusinessModelProtocol else { return UIViewController() }
        
        guard let viewController: ThirdViewController = getViewControllerFromStoryboard() else { return UIViewController() }
        viewController.viewModel = ThirdViewModel(businessModel: businessModel, someViewModelProperty: someProperty)
        viewController.flowDelegate = flowDelegate as? ThirdViewControllerFlowDelegate
        
        return viewController
    }
    
    func createFourthViewController<B, F>(from viewModel: BaseViewModel<B>?, and flowDelegate: F?) -> UIViewController {
        guard let businessModel = getBusinessModel(from: viewModel) as? FourthBusinessModelProtocol else { return UIViewController() }
        
        guard let viewController: FourthViewController = getViewControllerFromStoryboard() else { return UIViewController() }
        viewController.viewModel = FourthViewModel(businessModel: businessModel)
        viewController.flowDelegate = flowDelegate as? FourthViewControllerFlowDelegate
        
        return viewController
    }
}
