//
//  DataBaseManager.swift
//  FileManager
//
//  Created by Гузель on 08/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import RealmSwift
import SDWebImage

class DataBaseManager: DataBaseManagerProtocol {
    
    fileprivate lazy var mainRealm: Realm = try! Realm(configuration: .defaultConfiguration)
    var folders: [FolderModel] = []
    
    func clearAll() {
        
        try! mainRealm.write {
            mainRealm.deleteAll()
        }
    }
    
    func saveItem(item: Object) {
        
        try! mainRealm.write {
            mainRealm.add(item)
        }
    }
    
    func removeItem(item: Object) {
        
        try! mainRealm.write {
            mainRealm.delete(item)
        }
    }
    
    func updateItem(item: Object) {
        
        
        try! mainRealm.write {
            mainRealm.add(item, update: true)
        }
    }
    
    func obtainFolders() -> [FolderModel] {
        
        let items = mainRealm.objects(FolderModel.self)
        folders = []
        
        for item in Array(items) {
            allFolders(object: item)
            folders.append(item)
        }
        
        return folders
    }
    
    /// Рекурсивынй метод для нахождения папок внутри папок
    ///
    /// - Parameter object: Папка
    func allFolders(object: FolderModel) {
        
        if !(object.folders?.isEmpty)! {
            
            for obj in object.folders! {
                
                allFolders(object: obj)
                folders.append(obj)
            }
        }
    }
    
    func performTransaction(transaction: () -> ()) {
        
        try! mainRealm.write {
            transaction()
        }
    }
    
    func obtainTextFiles() -> [TextFileModel] {
        
        let items = mainRealm.objects(TextFileModel.self)
        
        return Array(items)
    }
    
    func obtainMediaFiles() -> [MediaModel] {
        
        let items = mainRealm.objects(MediaModel.self)
        
        return Array(items)
    }
}
