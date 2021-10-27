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
    func start(businessModel: SampleFeatureBusinessModelProtocol) -> UIViewController
}

class SampleFeatureFlow: SampleFeatureFlowProtocol {
    let factory: SampleFeatureViewControllerFactoryProtocol
    weak var featureDelegate: SampleFeatureDelegate?
    
    init(factory: SampleFeatureViewControllerFactoryProtocol, featureDelegate: SampleFeatureDelegate? = nil) {
        self.factory = factory
        self.featureDelegate = featureDelegate
    }
    
    func start(businessModel: SampleFeatureBusinessModelProtocol) -> UIViewController {
        let firstViewModel = FirstViewModel(businessModel: businessModel)
        let firstViewController = UIViewController.instantiateVC(ofType: FirstViewController.self)!
        firstViewController.viewModel = firstViewModel
        firstViewController.flowDelegate = self
        
        return firstViewController
    }
}

// MARK: - FirstViewControllerFlowDelegate

extension SampleFeatureFlow: FirstViewControllerFlowDelegate {
    func onFirstButtonClick(in controller: BaseViewController<FirstViewModelProtocol, FirstViewControllerFlowDelegate>) {
        let nextVC = factory.createSecondViewController(from: controller.viewModel as? BaseViewModel<FirstBusinessModelProtocol>, and: self)
        controller.show(nextVC, sender: nil)
    }
    
    func onSecondButtonClick(in controller: BaseViewController<FirstViewModelProtocol, FirstViewControllerFlowDelegate>) {
        guard let someProperty = controller.viewModel?.getBusinessProperty() else { return }
        let nextVC = factory.createThirdViewController(from: controller.viewModel as? BaseViewModel<FirstBusinessModelProtocol>, flowDelegate: self, someProperty: someProperty)
        controller.show(nextVC, sender: nil)
    }
}

// MARK: - SecondViewControllerFlowDelegate

extension SampleFeatureFlow: SecondViewControllerFlowDelegate {
    func onFirstButtonClick(in controller: BaseViewController<SecondViewModelProtocol, SecondViewControllerFlowDelegate>) {
        let nextVC = factory.createFourthViewController(from: controller.viewModel as? BaseViewModel<SecondBusinessModelProtocol>, and: self)
        controller.show(nextVC, sender: nil)
    }
}

// MARK: - ThirdViewControllerFlowDelegate

extension SampleFeatureFlow: ThirdViewControllerFlowDelegate {
    func onDidLoadAfterTwoSeconds(in controller: BaseViewController<ThirdViewModelProtocol, ThirdViewControllerFlowDelegate>) {
        let nextVC = factory.createFourthViewController(from: controller.viewModel as? BaseViewModel<ThirdBusinessModelProtocol>, and: self)
        controller.show(nextVC, sender: nil)
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
