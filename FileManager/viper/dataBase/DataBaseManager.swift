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
    var weight: [Int] = []
    
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
    
    func obtainById(id: Int) -> [Object]? {
        
        let folders = mainRealm.objects(FolderModel.self)
        
        var items: [Object] = []
        
        for item in Array(folders) {
            if item.id == id {
                for i in item.folders! {
                    
                    items.append(i)
                }
            }
        }
        
        return items
    }
    
    func allFolders(object: FolderModel) {
        
        if !(object.folders?.isEmpty)! {
            for obj in object.folders! {
                allFolders(object: obj)
                folders.append(obj)
            }
        }
    }
    
    func saveImage(_ path: String, item: Object) {
        
        performTransaction {
            (item as! MediaModel).path = path
        }
        updateItem(item: item)
    }
    
    func getFolderById(id: Int) -> FolderModel? {
        
        let items = Array(mainRealm.objects(FolderModel.self))

        for item in items {
            if item.id == id { return item }
        }
        
        return nil
    }
    
    func obtainWeight(item: Object) -> Double {
        weight = []
        var size: Int = 0
        
        obtain(item: item)
        for i in weight {
            size+=i
        }
        return Double(size) / 1024
    }
    
    func obtain(item: Object){
        if let folder = item as? FolderModel {
            for i in folder.folders! {
                obtain(item: i)
            }
            for i in folder.textFiles! {
                obtain(item: i)
            }
            for i in folder.media! {
                obtain(item: i)
            }
        }
        if let text = item as? TextFileModel {
            weight.append(((text.content).data(using: .utf8))?.count ?? 0)
        }
        if let media = item as? MediaModel {
            let image = UIImageView()
            image.sd_setImage(with: URL(string: media.path), completed: nil)
            weight.append(image.image?.pngData()!.count ?? 0)
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
    
    func obtainLastId() -> Int {
        
        let f = Array(obtainFolders())
        let t = Array(obtainTextFiles())
        let m = Array(obtainMediaFiles())
        var id: [Int] = []
        
        for i in f {
            id.append(i.id)
        }
        for i in t {
            id.append(i.value(forKey: "id") as! Int)
        }
        for i in m {
            id.append(i.value(forKey: "id") as! Int)
        }
        
        return id.max() ?? 0
    }
    
    func deleteItem(_ item: Object, _ folder: FolderModel) {
        
        if let folder1 = item as? FolderModel {
            for item in folder1.folders! {
                if item != nil {
                    deleteItem(item, folder)
//                    }
                }
            }
            for item in folder1.textFiles! {
                try! mainRealm.write {
                    mainRealm.delete(item)
                }
            }
            for item in folder1.media! {
                try! mainRealm.write {
                    mainRealm.delete(item)
                }
            }
            try! mainRealm.write {
                mainRealm.delete(folder1)
            }
        }
        if let text = item as? TextFileModel {
            try! mainRealm.write {
                mainRealm.delete(text)
            }
        }
        if let media = item as? MediaModel {
            try! mainRealm.write {
                mainRealm.delete(media)
            }
        }
        
        updateItem(item: folder)
    }
    
    func editNameOfObject(_ item: Object, _ folder: FolderModel, _ textField: String?) {
        
        if let folder1 = item as? FolderModel {
            performTransaction {
                if textField == "" {
                    folder1.name = "Default"
                } else {
                    folder1.name = textField ?? "Default"
                }
            }
            updateItem(item: folder1)
        }
        if let text = item as? TextFileModel {
            performTransaction {
                if textField == "" {
                    text.name = "Default"
                } else {
                    text.name = textField ?? "Default"
                }
            }
            updateItem(item: text)
        }
        if let media = item as? MediaModel {
            performTransaction {
                if textField == "" {
                    media.name = "Default"
                } else {
                    media.name = textField ?? "Default"
                }
            }
            updateItem(item: media)
        }
        updateItem(item: folder)
    }
}
