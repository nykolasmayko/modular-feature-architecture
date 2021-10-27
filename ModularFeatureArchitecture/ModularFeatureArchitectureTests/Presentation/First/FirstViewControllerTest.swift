//
//  FirstViewControllerTest.swift
//  ModularFeatureArchitectureTests
//
//  Created by Nykolas Mayko Maia Barbosa on 07/10/21.
//

import XCTest
@testable import ModularFeatureArchitecture

class FirstViewControllerTest: XCTestCase {
    func test_viewDidLoad_setFirstButtonTitle() throws {
        let controller = makeSUT()
        controller.loadViewIfNeeded()
        
        XCTAssertEqual(controller.firstButton.title(for: .normal), "One - Mock")
    }
    
    // MARK: Helpers
    
    func makeSUT() -> FirstViewController {
        let viewController = UIViewController.instantiateVC(ofType: FirstViewController.self)!
        viewController.viewModel = MockFirstViewModel()
        
        return viewController
    }
    
    class MockFirstViewModel: FirstViewModelProtocol {
        func getBusinessProperty() -> String {
            return "One - Mock"
        }
        
        func getBusinessModel<BusinessModel>() -> BusinessModel? {
            return nil
        }
        
        func getFlow<FlowDelegate>() -> FlowDelegate? {
            return nil
        }
    }
}
