//
//  CreateListModel.swift
//  shopping-list
//
//  Created by Mason Phillips on 8/12/20.
//

import Foundation

class CreateListModel: BaseModel {
    func saveList(name: String, items: [String]) {
        services.coreData.saveNewList(name: name, items: items)
    }
}
