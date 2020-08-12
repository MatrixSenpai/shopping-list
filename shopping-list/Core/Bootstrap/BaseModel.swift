//
//  BaseModel.swift
//  shopping-list
//
//  Created by Mason Phillips on 8/11/20.
//

import Foundation
import RxCocoa
import RxSwift

class BaseModel: NSObject {
    let services: AppServices
    let bag = DisposeBag()
    
    let errorRelay = BehaviorRelay<Error?>(value: nil)
    
    required init(_ services: AppServices) {
        self.services = services
        super.init()
    }
}
