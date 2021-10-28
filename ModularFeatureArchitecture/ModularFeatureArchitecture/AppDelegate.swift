//
//  AppDelegate.swift
//  ModularFeatureArchitecture
//
//  Created by Nykolas Mayko Maia Barbosa on 27/10/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, SampleFeatureDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController()
        
        let sampleFeatureLauncher = SampleFeatureLauncher(network: "Passar aqui o módulo estrutural de Networking", analytics: "Passar aqui o módulo estrutural de Analytics")
        
//        navigationController.pushViewController(sampleFeatureLauncher.get(.third(useCase: AnotherSampleFeatureBusinessModel(), analytics: AnotherSampleFeatureBusinessModel(), flowDelegate: AnotherSampleFlow(), someProperty: "Nykolas")), animated: true)
        
//        navigationController.pushViewController(sampleFeatureLauncher.start(delegate: self), animated: true)
        
        navigationController.pushViewController(sampleFeatureLauncher.start(deeplink: "app://sample-feature/second", delegate: self), animated: true)
//        navigationController.setViewControllers(sampleFeatureLauncher.start(deeplink: "app://sample-feature/second", delegate: self), animated: true)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        
        return true
    }
    
    func didFinish(in viewController: UIViewController) {
        print("terminou!")
        viewController.navigationController?.popToRootViewController(animated: true)
    }
}

class AnotherSampleFeatureBusinessModel: ThirdBusinessModelProtocol, ThirdAnalyticsProtocol {
    var someThirdBusinessProperty: String = "three"
    
    var someSecondBusinessProperty: String = "two"
}

class AnotherSampleFlow: ThirdViewControllerFlowDelegate {
    func onDidLoadAfterTwoSeconds(in controller: BaseViewController<ThirdViewModelProtocol, ThirdViewControllerFlowDelegate>) {
        print("Aqui posso optar por seguir o fluxo, então, implemento os outros protocolos da BusinessModel, ViewModel e ViewController ou adiciono alguma tela do meu fluxo onde já tenho tudo implementado.")
    }
    
    func onFirstButtonClick(in controller: BaseViewController<SecondViewModelProtocol, SecondViewControllerFlowDelegate>) {
        print("Aqui posso optar por seguir o fluxo, então, implemento os outros protocolos da BusinessModel, ViewModel e ViewController ou adiciono alguma tela do meu fluxo onde já tenho tudo implementado.")
    }
}
