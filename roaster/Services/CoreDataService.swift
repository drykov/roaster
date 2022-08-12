//
//  CoreDataService.swift
//  roaster
//
//  Created by Dmitry Rykov on 11.08.2022.
//

import Foundation
import CoreData

protocol CoreDataService {
    
    var context: NSManagedObjectContext { get }
}
