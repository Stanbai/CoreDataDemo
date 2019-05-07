//
//  CoreDataStack.swift
//  ForthCoredataFetch
//
//  Created by Stan on 2017-12-23.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer.init(name: modelName)
        container.loadPersistentStores(completionHandler: { (sotreDescription, error) in
            if let error = error as NSError? {
                print("Unknown error:\(error),\(error.userInfo)")
            }
        })
        
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        return storeContainer.viewContext
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch  {
            let error = error as NSError
            print("Unknown error:\(error),\(error.userInfo)")
        }
    }
}
