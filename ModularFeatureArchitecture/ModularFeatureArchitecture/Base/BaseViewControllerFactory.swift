//
//  BaseRouter.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 11/10/21.
//

import UIKit

open class BaseViewControllerFactory {
    func getBusinessModel<B>(from viewModel: BaseViewModel<B>?) -> B? {
        guard let viewModel = viewModel else {
            assertionFailure("The viewModel property cannot be nil")
            return nil
        }
        
        guard let businessModel: B = viewModel.getBusinessModel() else {
            assertionFailure("The BusinessModel should implement the \(B.self)")
            return nil
        }
        
        return businessModel
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
