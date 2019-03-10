//
//  DataBaseManagerProtocol.swift
//  FileManager
//
//  Created by Гузель on 08/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import RealmSwift

protocol DataBaseManagerProtocol: AnyObject {

    func clearAll()
    
    func obtainLastId() -> Int
    
    func saveItem(item: Object)
    
    func removeItem(item: Object)
    
    func updateItem(item: Object)
    
    func obtainFolders() -> [FolderModel]
    
    func obtainWeight(item: Object) -> Double
    
    func obtainTextFiles() -> [TextFileModel]
    
    func obtainMediaFiles() -> [MediaModel]
    
    func obtainById(id: Int) -> [Object]?
    
    func getFolderById(id: Int) -> FolderModel?
    
    func saveImage(_ path: String, item: Object)
    
    func performTransaction(transaction: () -> ())
    
    func deleteItem(_ item: Object, _ folder: FolderModel)
    
    func editNameOfObject(_ item: Object, _ folder: FolderModel, _ textField: String?)
}
