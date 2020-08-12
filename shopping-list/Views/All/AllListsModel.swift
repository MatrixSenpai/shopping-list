//
//  AllListsModel.swift
//  shopping-list
//
//  Created by Mason Phillips on 8/11/20.
//

import Foundation
import RxCocoa
import RxSwift

class AllListsModel: BaseModel {
    let listRelay = BehaviorRelay<[List]>(value: [])
    
    required init(_ services: AppServices) {
        super.init(services)
        
        self.fetchLists()
    }
    
    func fetchLists() {
        let results = services.coreData.fetchLists()
        listRelay.accept(results)
    }
}
