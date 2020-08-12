//
//  AppDelegate.swift
//  shopping-list
//
//  Created by Mason Phillips on 8/11/20.
//

import UIKit
import CoreData
import FontBlaster

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FontBlaster.blast()
        
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        self.saveContext()
    }

    lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "shopping-list-model")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved issue: \(error.localizedDescription)")
            }
        }
        
        return container
    }()
    
    func saveContext() {
        let context = persistantContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Unresolved error: \(error.localizedDescription)")
            }
        }
    }
}

