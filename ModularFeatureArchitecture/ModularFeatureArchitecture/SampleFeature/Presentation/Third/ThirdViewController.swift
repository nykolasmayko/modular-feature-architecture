//
//  ThirdViewController.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 27/09/21.
//

import UIKit

public protocol ThirdViewControllerFlowDelegate {
    func onDidLoadAfterTwoSeconds(in controller: BaseViewController<ThirdViewModelProtocol, ThirdViewControllerFlowDelegate>)
}

class ThirdViewController: BaseViewController<ThirdViewModelProtocol, ThirdViewControllerFlowDelegate> {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(viewModel?.getBusinessProperty() ?? "")
        print(viewModel?.someViewModelProperty ?? "")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return }
            self.flowDelegate?.onDidLoadAfterTwoSeconds(in: self)
        }
    }
}
