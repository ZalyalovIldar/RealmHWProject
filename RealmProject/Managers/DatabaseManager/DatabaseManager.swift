//
//  DatabaseManager.swift
//  RealmProject
//
//  Created by Петр on 27/02/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import RealmSwift

final class DatabaseManager: DatabaseManagerProtocol {
    
    internal lazy var mainRealm: Realm = try! Realm(configuration: .defaultConfiguration)
    
    
    // MARK: - Operation queues
    
    private lazy var getOperationQueue: OperationQueue = {
        
        let queue = OperationQueue()
        queue.qualityOfService = .userInteractive
        queue.name = "Get operation queue"
        
        return queue
    }()
    
    private lazy var saveOperationQueue: OperationQueue = {
        
        let queue = OperationQueue()
        queue.name = "Save operation queue"
        
        return queue
    }()
    
    private lazy var deleteOperationQueue: OperationQueue = {
        
        let queue = OperationQueue()
        queue.name = "Delete operation queue"
        
        return queue
    }()
    
    
    // MARK: - Get objects
    
    func getObjects<T>(with type: T.Type) -> Array<T>? where T : Object {
        
        return Array(mainRealm.objects(T.self))
    }
    
    func asyncGetObjects<T>(with type: T.Type, completionBlock: @escaping (Array<T>?) -> Void) where T : Object {
        
        getOperationQueue.addOperation {
            completionBlock(self.getObjects(with: T.self))
        }
    }
    
    
    // MARK: - Save objects
    
    func saveObjects<T>(objects: Array<T>) where T : Object {
        
        try! mainRealm.write {
            mainRealm.add(objects)
        }
    }
    
    func asyncSaveObjects<T>(objects: Array<T>, completionBlock: @escaping (Bool) -> Void) where T : Object {
        
        saveOperationQueue.addOperation {
            
            self.saveObjects(objects: objects)
            completionBlock(true)
        }
    }
    
    
    // MARK: - Delete objects
    
    func deleteObjects<T>(objects: Array<T>) where T : Object {
        
        try! mainRealm.write {
            mainRealm.delete(objects, cascading: true)
        }
    }
    
    func asyncDelete<T>(objects: Array<T>, completionBlock: @escaping (Bool) -> Void) where T : Object {
        
        DispatchQueue.main.async {
            self.deleteObjects(objects: objects)
        }
    }
    
    func clearAll() {
        
        try! mainRealm.write {
            mainRealm.deleteAll()
        }
    }
    
    func performTransaction(transaction: () -> ()) {
        
        try! mainRealm.write {
            transaction()
        }
    }
}
