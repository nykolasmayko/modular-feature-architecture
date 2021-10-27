//
//  SampleFlowControllerTests.swift
//  ModularFeatureArchitectureTests
//
//  Created by Nykolas Mayko Maia Barbosa on 27/09/21.
//

import XCTest
@testable import ModularFeatureArchitecture

class SampleFlowControllerTests: XCTestCase {
    func test_onFirstButtonClick_goToSecondViewController() throws {
        let flowController = makeSUT()
        let viewModel = FirstViewModel(businessModel: businessModel)
        let viewController = FirstViewController(viewModel: viewModel, flowDelegate: flowController)
        let _ = NonAnimatedNavigation(rootViewController: viewController)
        
        flowController.onFirstButtonClick(in: viewController)
        
        XCTAssert(viewController.navigationController?.viewControllers.last is SecondViewController)
    }
    
    func test_onFirstButtonClick_goToThirdViewController() throws {
        let flowController = makeSUT()
        let viewModel = FirstViewModel(businessModel: businessModel)
        let viewController = FirstViewController(viewModel: viewModel, flowDelegate: flowController)
        let _ = NonAnimatedNavigation(rootViewController: viewController)
        
        flowController.onSecondButtonClick(in: viewController)
        
        XCTAssert(viewController.navigationController?.viewControllers.last is ThirdViewController)
    }
    
    func test_onSecondViewFirstButtonClick_goToFourthViewController() throws {
        let flowController = makeSUT()
        let viewModel = SecondViewModel(businessModel: businessModel)
        let viewController = SecondViewController(viewModel: viewModel, flowDelegate: flowController)
        let _ = NonAnimatedNavigation(rootViewController: viewController)
        
        flowController.onFirstButtonClick(in: viewController)
        
        XCTAssert(viewController.navigationController?.viewControllers.last is FourthViewController)
    }
    
    func test_onDidLoadAfterTwoSecondsThirdViewFlow_goToFourthViewController() throws {
        let flowController = makeSUT()
        let viewModel = ThirdViewModel(businessModel: businessModel, someViewModelProperty: "hahahah")
        let viewController = ThirdViewController(viewModel: viewModel, flowDelegate: flowController)
        let _ = NonAnimatedNavigation(rootViewController: viewController)
        
        flowController.onDidLoadAfterTwoSeconds(in: viewController)
        
        XCTAssert(viewController.navigationController?.viewControllers.last is FourthViewController)
    }
    
    func test_onDidLoadAfterTwoSecondsFourthViewFlow_goToRootViewController() throws {
        let flowController = makeSUT()
        let viewModel = FourthViewModel(businessModel: businessModel)
        let viewController = FourthViewController(viewModel: viewModel, flowDelegate: flowController)
        let _ = NonAnimatedNavigation(rootViewController: viewController)
        
        flowController.onDidLoadAfterTwoSeconds(in: viewController)
        
        XCTAssert(viewController.navigationController?.viewControllers.first is FourthViewController)
    }
    
    // MARK: Helpers
    
    let businessModel = SampleFeatureBusinessModel(repository: SampleFeatureApiMock())
    let controllerFactory = SampleFeatureViewControllerFactory()
    
    func makeSUT() -> SampleFeatureFlow {
        return SampleFeatureFlow(factory: controllerFactory)
    }
    
    class NonAnimatedNavigation: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
        
        override func popToRootViewController(animated: Bool) -> [UIViewController]? {
            super.popToRootViewController(animated: false)
        }
    }
}
