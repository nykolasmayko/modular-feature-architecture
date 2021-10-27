//
//  BaseViewController.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 01/10/21.
//

import UIKit

public protocol BaseViewControllerProtocol {
    associatedtype ViewModel
    associatedtype FlowDelegate
    var viewModel: ViewModel? { get set }
    var flowDelegate: FlowDelegate? { get set }
}

open class BaseViewController<T, F>: UIViewController, BaseViewControllerProtocol {
    public typealias ViewModel = T
    public typealias FlowDelegate = F
    
    public var viewModel: ViewModel?
    public var flowDelegate: FlowDelegate?
    
    init(viewModel: ViewModel?, flowDelegate: FlowDelegate?) {
        self.viewModel = viewModel
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
