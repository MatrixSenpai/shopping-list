//
//  AppServices.swift
//  shopping-list
//
//  Created by Mason Phillips on 8/11/20.
//

import Foundation
import CoreData
import LibSnowflake

struct AppServices {
    let coreData: CoreDataService
    init(_ model: NSPersistentContainer) {
        self.coreData = CoreDataService(model.viewContext)
    }
}

struct CoreDataService {
    let container: NSManagedObjectContext
    
    init(_ container: NSManagedObjectContext) {
        self.container = container
    }
    
    func fetchLists() -> [List] {
        let request: NSFetchRequest<List> = List.fetchRequest()
        
        do {
            let lists = try container.fetch(request)
            return lists
        } catch {
            print("Could not fetch lists. \(error.localizedDescription)")
            return []
        }
    }
    
    func saveNewList(name: String, items: [String]) {
        guard let list = NSEntityDescription.insertNewObject(forEntityName: "List", into: container) as? List else {
            fatalError("Failed to create new list")
        }
        list.identifier = Snowflake()
        list.name = name
        list.createdAt = Date()
        list.updatedAt = Date()
        
        for item in items {
            guard let listItem = NSEntityDescription.insertNewObject(forEntityName: "ListItem", into: container) as? ListItem else {
                fatalError("Failed to create new list item")
            }
            listItem.name = item
            
            listItem.list = list
            list.addToItems(listItem)
        }
        
        do {
            try container.save()
        } catch {
            let lis: String = items.reduce("") { $0 + " \($1)" }
            fatalError("Failed to save something...\n \(name) (\(items.count) items)\n\(lis)\n\(error.localizedDescription)")
        }
    }
}
