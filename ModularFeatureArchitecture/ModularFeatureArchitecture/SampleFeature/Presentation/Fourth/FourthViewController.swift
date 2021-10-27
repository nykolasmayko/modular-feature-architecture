//
//  FourthViewController.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 27/09/21.
//

import UIKit

public protocol FourthViewControllerFlowDelegate {
    func  onDidLoadAfterTwoSeconds(in controller: BaseViewController<FouthViewModelProtocol, FourthViewControllerFlowDelegate>)
}

class FourthViewController: BaseViewController<FouthViewModelProtocol, FourthViewControllerFlowDelegate> {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(viewModel?.getBusinessProperty() ?? "")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return }
            self.flowDelegate?.onDidLoadAfterTwoSeconds(in: self)
        }
    }
}
