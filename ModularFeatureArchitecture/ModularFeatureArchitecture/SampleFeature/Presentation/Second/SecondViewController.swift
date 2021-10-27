//
//  SecondViewController.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 27/09/21.
//

import UIKit

public protocol SecondViewControllerFlowDelegate {
    func onFirstButtonClick(in controller: BaseViewController<SecondViewModelProtocol, SecondViewControllerFlowDelegate>)
}

class SecondViewController: BaseViewController<SecondViewModelProtocol, SecondViewControllerFlowDelegate> {
    @IBOutlet weak var firstButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(viewModel?.getBusinessProperty() ?? "")
    }
    
    @IBAction func onFirstButtonClick(_ sender: Any) {
        flowDelegate?.onFirstButtonClick(in: self)
    }
}
