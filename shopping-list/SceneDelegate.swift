//
//  SceneDelegate.swift
//  shopping-list
//
//  Created by Mason Phillips on 8/11/20.
//

import UIKit
import RxFlow
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    let coordinator = FlowCoordinator()
    let bag = DisposeBag()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        coordinator.rx.willNavigate.subscribe(onNext: { arg in
            print("WILLNAV: \(arg.0) -> \(arg.1)")
        }).disposed(by: bag)
        coordinator.rx.didNavigate.subscribe(onNext: { arg in
            print("DIDNAV: \(arg.0) -> \(arg.1)")
        }).disposed(by: bag)
        
        guard let container = (UIApplication.shared.delegate as? AppDelegate)?.persistantContainer else {
            fatalError("Could not get container from appdelegate")
        }
        let services = AppServices(container)
        
        let flow = AppFlow(services)
        Flows.use(flow, when: .ready) { [unowned window] root in
            window?.rootViewController = root
            window?.makeKeyAndVisible()
        }
        coordinator.coordinate(flow: flow, with: flow.stepper)
    }

    func sceneDidEnterBackground(_ scene: UIScene) { // Will be used to save to coredata
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

