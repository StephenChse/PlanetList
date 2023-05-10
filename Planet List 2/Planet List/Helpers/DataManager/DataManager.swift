//
//  DataManager.swift
//  JPMC MCoE
//
//  Created by Stephen Chase on 09/05/2023.
//

import Foundation
import CoreData

class DataManager: NSObject {
    
    private var persistentContainer: NSPersistentContainer!
    public var viewContext: NSManagedObjectContext {
        let context = persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.automaticallyMergesChangesFromParent = true
        return context
    }
    
    static let shared = DataManager()
    
    public func load(_ completion: @escaping (Error?)->()) {
        persistentContainer = NSPersistentContainer(name: "Planet")
        
        let storeDescription = persistentContainer.persistentStoreDescriptions.first!
        storeDescription.setOption(true as NSNumber,
                                   forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            completion(error)
        })
    }
    
    // MARK: - Core Data Saving support
    
    public func saveContext(_ context: NSManagedObjectContext? = nil) {
        let context = context ?? viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
