//
//  DataController.swift
//  GameList
//
//  Created by IGI on 17.04.16.
//  Copyright © 2016 IGI2k. All rights reserved.
//

import CoreData;
import UIKit;


protocol DataControllerDelegate : NSFetchedResultsControllerDelegate {
    
    func getSectionNameKeyPath() -> String?
    
    func getSortDescriptors() -> [NSSortDescriptor]?
}

extension DataControllerDelegate {
    
    func getSectionNameKeyPath() -> String? {
        return nil;
    }
    
    func getSortDescriptors() -> [NSSortDescriptor]? {
        return nil;        
    }
}

class Filter<T : NSManagedObject where T: EntityInitialSort> {
    
    unowned private let dataController: DataController<T>
    
    init (dataController: DataController<T>) {
        self.dataController = dataController
    }
    
    func contains(key: String, value: String) -> DataController<T> {
        if(!value.isEmpty) {
            dataController.fetchRequest.predicate = NSPredicate(format: "%K CONTAINS[cd] %@", key, value)
        } else {
            dataController.fetchRequest.predicate = nil
        }
        return dataController
    }
}

class DataController<T: NSManagedObject where T: EntityInitialSort> : NSFetchedResultsController {
    
    private(set) var filter: Filter<T>!
    
    init(entityName: String, delegate: DataControllerDelegate, cacheName: String? = nil) {
        
        let request = NSFetchRequest(entityName: entityName)
        if let sortDescriptors = delegate.getSortDescriptors() {
            request.sortDescriptors = sortDescriptors
        } else {
            // use default
            request.sortDescriptors = T.initialSort
        }
        
        //TODO: dependency injection?
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        super.init(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: delegate.getSectionNameKeyPath(), cacheName: cacheName)
        
        super.delegate = delegate
        self.filter = Filter(dataController: self)
    }
        
    func getObject(indexPath: NSIndexPath) -> T {
        return super.objectAtIndexPath(indexPath) as! T
    }
    
    func deleteObject(object: T) {
        super.managedObjectContext.deleteObject(object);
    }
    
    func deleteObject(indexPath: NSIndexPath) {
        return deleteObject(getObject(indexPath))
    }
    
    func createNewObject<MO: NSManagedObject>(entitiyName: String) -> MO {
        return NSEntityDescription.insertNewObjectForEntityForName(entitiyName, inManagedObjectContext: managedObjectContext) as! MO
    }
    
    func fetch(errorMessage: String) -> DataController<T> {

        // cache is persisted as well
        if(self.cacheName != nil){
            NSFetchedResultsController.deleteCacheWithName(self.cacheName)
        }
        
        do {
            try super.performFetch()
        } catch {
            fatalError(errorMessage + ": \(error)")
        }
        
        return self
    }
    
    func saveContext () {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.saveContext()
    }
}