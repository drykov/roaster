//
//  CoreDataServiceImpl.swift
//  roaster
//
//  Created by Dmitry Rykov on 11.08.2022.
//

import Foundation
import CoreData

class CoreDataServiceImpl: CoreDataService {
    
    static let shared = CoreDataServiceImpl()
    
    init() {
        let container = NSPersistentCloudKitContainer(name: "roaster")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Can't init core data \(error)")
            }
        }
        context = container.viewContext
    }
    
    var context: NSManagedObjectContext
}
