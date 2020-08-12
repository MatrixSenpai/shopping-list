//
//  Reusable+SL.swift
//  shopping-list
//
//  Created by Mason Phillips on 8/11/20.
//

import UIKit
import Reusable

protocol BaseControllerType: UIViewController {
    associatedtype Model: BaseModel
    var model: Model! { get set }
    
    var stepper: AppStepper! { get set }
}

extension StoryboardBased where Self: BaseControllerType {
    static func instantiate(_ services: AppServices, stepper: AppStepper) -> Self {
        let controller = Self.instantiate()
        let model = Self.Model.init(services)
        
        controller.model = model
        controller.stepper = stepper
        
        return controller
    }
}
