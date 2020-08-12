//
//  AppFlow.swift
//  shopping-list
//
//  Created by Mason Phillips on 8/11/20.
//

import UIKit
import RxCocoa
import RxFlow
import RxSwift
import LibSnowflake

class AppFlow: Flow {
    var root: Presentable {
        return rootViewController
    }
    
    private let rootViewController = UINavigationController()
    
    let stepper = AppStepper()
    let services: AppServices
    
    init(_ services: AppServices) {
        self.services = services
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        
        switch step {
        case .allLists    : return toAllLists()
        case .list(let id): return toOneList(id: id)
        case .create      : return toCreate()
        case .done        : return viewDone()
        }
    }
    
    private func toAllLists() -> FlowContributors {
        let controller = AllListsController.instantiate(services, stepper: stepper)
        rootViewController.pushViewController(controller, animated: false)
        return .none
    }
    private func toOneList(id: Snowflake) -> FlowContributors {
        return .none
    }
    private func toCreate() -> FlowContributors {
        let controller = CreateListController()
        controller.stepper = stepper
        controller.model = CreateListModel(services)
        rootViewController.pushViewController(controller, animated: true)
        return .none
    }
    private func viewDone() -> FlowContributors {
        rootViewController.popViewController(animated: true)
        return .none
    }
}

struct AppStepper: Stepper {
    let steps = PublishRelay<Step>()
    let initialStep = AppStep.allLists
    
    func readyToEmitSteps() {
        steps.accept(initialStep)
    }
}
