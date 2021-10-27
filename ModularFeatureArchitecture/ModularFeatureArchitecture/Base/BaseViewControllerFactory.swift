//
//  BaseRouter.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 11/10/21.
//

import UIKit

open class BaseViewControllerFactory {
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
