//
//  CoreDataStack.swift
//  Attendance
//
//  Created by Stan on 2017-12-02.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }

    
    lazy var storeContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: self.modelName)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                debugPrint("Unclear error\(error)")
            }
        })
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            debugPrint("Unclear error\(error)")
        }
        
    }
}
