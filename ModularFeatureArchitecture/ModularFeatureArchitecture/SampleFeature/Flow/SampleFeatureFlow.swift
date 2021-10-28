//
//  FlowController.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 28/09/21.
//

import Foundation
import UIKit

public protocol SampleFeatureFlowProtocol {
    var factory: SampleFeatureViewControllerFactoryProtocol { get }
    var featureDelegate: SampleFeatureDelegate? { get set }
    func start(useCase: SampleFeatureUseCaseProtocol, analytics: SampleFeatureAnalyticsProtocol) -> UIViewController
    func show(_ destinationViewController: UIViewController, from currentViewController: UIViewController, sender: Any?)
}

class SampleFeatureFlow: SampleFeatureFlowProtocol {
    let factory: SampleFeatureViewControllerFactoryProtocol
    weak var featureDelegate: SampleFeatureDelegate?
    
    init(factory: SampleFeatureViewControllerFactoryProtocol, featureDelegate: SampleFeatureDelegate? = nil) {
        self.factory = factory
        self.featureDelegate = featureDelegate
    }
    
    func start(useCase: SampleFeatureUseCaseProtocol, analytics: SampleFeatureAnalyticsProtocol) -> UIViewController {
        return factory.createFirstViewController(useCase: useCase, analytics: analytics, and: self)
    }
    
    func show(_ destinationViewController: UIViewController, from currentViewController: UIViewController, sender: Any? = nil) {
        currentViewController.show(destinationViewController, sender: sender)
    }
}

// MARK: - FirstViewControllerFlowDelegate

extension SampleFeatureFlow: FirstViewControllerFlowDelegate {
    func onFirstButtonClick(in controller: BaseViewController<FirstViewModelProtocol, FirstViewControllerFlowDelegate>) {
        guard let viewModel = controller.viewModel else { return }
        
        let useCase: SecondBusinessModelProtocol? = viewModel.getUseCase()
        let analytics: SecondAnalyticsProtocol? = viewModel.getAnalytics()
        
        let nextVC = factory.createSecondViewController(useCase: useCase, analytics: analytics, and: self)
        show(nextVC, from: controller)
    }
    
    func onSecondButtonClick(in controller: BaseViewController<FirstViewModelProtocol, FirstViewControllerFlowDelegate>) {
        guard let viewModel = controller.viewModel else { return }
        
        let useCase: ThirdBusinessModelProtocol? = viewModel.getUseCase()
        let analytics: ThirdAnalyticsProtocol? = viewModel.getAnalytics()
        
        let nextVC = factory.createThirdViewController(useCase: useCase, analytics: analytics, flowDelegate: self, and: viewModel.getBusinessProperty())
        show(nextVC, from: controller)
    }
}

// MARK: - SecondViewControllerFlowDelegate

extension SampleFeatureFlow: SecondViewControllerFlowDelegate {
    func onFirstButtonClick(in controller: BaseViewController<SecondViewModelProtocol, SecondViewControllerFlowDelegate>) {
        guard let viewModel = controller.viewModel else { return }
        
        let useCase: FourthBusinessModelProtocol? = viewModel.getUseCase()
        let analytics: FourthAnalyticsProtocol? = viewModel.getAnalytics()
        
        let nextVC = factory.createFourthViewController(useCase: useCase, analytics: analytics, and: self)
        show(nextVC, from: controller)
    }
}

// MARK: - ThirdViewControllerFlowDelegate

extension SampleFeatureFlow: ThirdViewControllerFlowDelegate {
    func onDidLoadAfterTwoSeconds(in controller: BaseViewController<ThirdViewModelProtocol, ThirdViewControllerFlowDelegate>) {
        guard let viewModel = controller.viewModel else { return }
        
        let useCase: FourthBusinessModelProtocol? = viewModel.getUseCase()
        let analytics: FourthAnalyticsProtocol? = viewModel.getAnalytics()
        
        let nextVC = factory.createFourthViewController(useCase: useCase, analytics: analytics, and: self)
        show(nextVC, from: controller)
    }
}

// MARK: - FourthViewControllerFlowDelegate

extension SampleFeatureFlow: FourthViewControllerFlowDelegate {
    func onDidLoadAfterTwoSeconds(in controller: BaseViewController<FouthViewModelProtocol, FourthViewControllerFlowDelegate>) {
        guard let featureDelegate = featureDelegate else {
            controller.navigationController?.popToRootViewController(animated: true)
            return
        }
        featureDelegate.didFinish(in: controller)
    }
}
