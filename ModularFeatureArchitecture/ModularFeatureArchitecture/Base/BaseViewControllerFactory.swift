//
//  BaseRouter.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 11/10/21.
//

import UIKit

open class BaseViewControllerFactory {
    func getUseCaseAndAnalytics<U, A>(from viewModel: BaseViewModel<U, A>?) -> (useCase: U, analytics: A)? {
        guard let viewModel = viewModel else {
            assertionFailure("The viewModel property cannot be nil")
            return nil
        }
        
        guard let useCase: U = viewModel.getUseCase() else {
            assertionFailure("The BusinessModel should implement the \(U.self)")
            return nil
        }
        
        guard let analytics: A = viewModel.getAnalytics() else {
            assertionFailure("The BusinessModel should implement the \(A.self)")
            return nil
        }
        
        return (useCase, analytics)
    }
    
    func getViewControllerFromStoryboard<T: UIViewController>() -> T? {
        guard let viewController = UIViewController.instantiateVC(ofType: T.self) else {
            print("The \(T.self) cannot be initialized")
            return nil
        }
        
        return viewController
    }
}

extension UIViewController {
    static func instantiateVC<T: UIViewController>(ofType type: T.Type, in storyboardName: String = "Main") -> T? {
        let identifier = String(describing: type.self)
        return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: identifier) as? T
    }
}
