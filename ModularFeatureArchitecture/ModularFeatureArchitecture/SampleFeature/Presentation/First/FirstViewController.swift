//
//  FirstViewController.swift
//  RouteTest
//
//  Created by Nykolas Mayko Maia Barbosa on 27/09/21.
//

import UIKit

public protocol FirstViewControllerFlowDelegate {
    func onFirstButtonClick(in controller: BaseViewController<FirstViewModelProtocol, FirstViewControllerFlowDelegate>)
    func onSecondButtonClick(in controller: BaseViewController<FirstViewModelProtocol, FirstViewControllerFlowDelegate>)
}

class FirstViewController: BaseViewController<FirstViewModelProtocol, FirstViewControllerFlowDelegate> {
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(viewModel?.getBusinessProperty() ?? "")
        
        firstButton.setTitle(viewModel?.getBusinessProperty(), for: .normal)
    }
    
    @IBAction func onFirstButtonClick(_ sender: Any) {
        viewModel?.onContinueButtonClick()
        flowDelegate?.onFirstButtonClick(in: self)
    }
    
    
    @IBAction func onSecondButtonClick(_ sender: Any) {
        flowDelegate?.onSecondButtonClick(in: self)
    }
}
