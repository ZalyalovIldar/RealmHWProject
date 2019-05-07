//
//  FileDirectoryInteractor.swift
//  FileManager
//
//  Created by Гузель on 02/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import RealmSwift

enum Type {
    
    static let _empty = ""
    static let folder = "folder"
    static let text = "text"
    static let image = "image"
    static let video = "video"
    static let media = "media"
}

class FileDirectoryInteractor: FileDirectoryInteractorInput {
    
    var dataManager: DataBaseManagerProtocol!
    var presenter: FileDirectoryInteractorOutput!
    var weight: [Int] = []
    
    func addNewItemToDirectory(item: FolderModel?, name: String?, type: String?) {
        
        if name != nil && type != nil {
            
            switch type {
                
            case Type.folder:
                
                let folderModel = FolderModel()
                folderModel.name = name!
                folderModel.time = Date()
    
                if(item == nil) {
                
                    folderModel.name = AllConstants.fileDirectory
                    folderModel.id = 1
                    dataManager.saveItem(item: folderModel)
                } else {
                    
                    var currentFolder = FolderModel()
                    currentFolder = self.getFolderById(id: (item?.id)!)!
                    folderModel.id = self.obtainLastId() + 1
                    
                    dataManager.performTransaction {
                        currentFolder.folders?.append(folderModel)
                    }
                    
                    dataManager.updateItem(item: currentFolder)
                    dataManager.updateItem(item: folderModel)
                    presenter.initItem(item: currentFolder)
                }
            case Type.text:
                
                var currentFolder = FolderModel()
                currentFolder = self.getFolderById(id: (item?.id)!)!
                let textFileModel = TextFileModel()
                textFileModel.name = name!
                textFileModel.time = Date()
                textFileModel.id = self.obtainLastId() + 1
                
                dataManager.performTransaction {
                    currentFolder.textFiles?.append(textFileModel)
                }
                
                dataManager.saveItem(item: currentFolder)
                presenter.initItem(item: currentFolder)
            case Type.image:
                
                var currentFolder = FolderModel()
                currentFolder = self.getFolderById(id: (item?.id)!)!
                let mediaModel = MediaModel()
                mediaModel.name = name!
                mediaModel.time = Date()
                mediaModel.id = self.obtainLastId() + 1
                
                dataManager.performTransaction {
                    currentFolder.media?.append(mediaModel)
                }
                
                dataManager.saveItem(item: currentFolder)
                presenter.initItem(item: currentFolder)
            case Type.video:
                
                var currentFolder = FolderModel()
                currentFolder = self.getFolderById(id: (item?.id)!)!
                let mediaModel = MediaModel()
                mediaModel.name = name!
                mediaModel.time = Date()
                mediaModel.id = self.obtainLastId() + 1
                
                dataManager.performTransaction {
                    currentFolder.media?.append(mediaModel)
                }
                
                dataManager.saveItem(item: currentFolder)
                presenter.initItem(item: currentFolder)
            default:
                break
            }
        }
    }
    
    func didFinishObtainingFolder(_ folder: FolderModel) {
        presenter.didFinishObtainingFolder(folder)
    }
    
    func deleteItem(_ item: Object, _ folder: FolderModel) {
        
        if let folder1 = item as? FolderModel {
            
            for item in folder1.folders! {
                if item != nil {
                    deleteItem(item, folder)
                }
            }
            
            for item in folder1.textFiles! {
                dataManager.removeItem(item: item)
            }
            
            for item in folder1.media! {
                dataManager.removeItem(item: item)
            }
            
            dataManager.removeItem(item: folder1)
        }
        
        if let text = item as? TextFileModel {
            dataManager.removeItem(item: text)
        }
        
        if let media = item as? MediaModel {
            dataManager.removeItem(item: media)
        }
        
        dataManager.updateItem(item: folder)
    }
    
    func editNameOfObject(_ item: Object, _ folder: FolderModel, _ textField: String?) {
        
        if let folder1 = item as? FolderModel {
            
            dataManager.performTransaction {
                if textField == AllConstants.empty {
                    folder1.name = AllConstants.defaultName
                } else {
                    folder1.name = textField ?? AllConstants.defaultName
                }
            }
            
            dataManager.updateItem(item: folder1)
        }
        
        if let text = item as? TextFileModel {
        
            dataManager.performTransaction {
                if textField == AllConstants.empty {
                    text.name = AllConstants.defaultName
                } else {
                    text.name = textField ?? AllConstants.defaultName
                }
            }
            
            dataManager.updateItem(item: text)
        }
        if let media = item as? MediaModel {
            
            dataManager.performTransaction {
                if textField == AllConstants.empty {
                    media.name = AllConstants.defaultName
                } else {
                    media.name = textField ?? AllConstants.defaultName
                }
            }
            
            dataManager.updateItem(item: media)
        }
        
        dataManager.updateItem(item: folder)
    }
    
    func getMainFolder() {
    
        var mainFolder: FolderModel! = self.getFolderById(id: 1)
        
        if mainFolder == nil {
        
            addNewItemToDirectory(item: nil, name: AllConstants.fileDirectory, type: Type.folder)
            mainFolder = self.getFolderById(id: 1)
        }
        
        presenter.didFinishObtainingFolder(mainFolder!)
    }
    
    func obtainWeight(item: Object) {
        
        let weight = self.obtainWeightOfItem(item: item)
    
        if weight != 0.0 {
            presenter.initCellWeight(text: String(format: AllConstants.format, weight))
        } else {
            presenter.initCellWeight(text: String(0))
        }
    }
    
    /// Получение веса объекта
    ///
    /// - Parameter item: объект
    /// - Returns: Вес в Double
    func obtainWeightOfItem(item: Object) -> Double {
        
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
        
            for folderItem in folder.folders! {
                obtain(item: folderItem)
            }
            
            for textItem in folder.textFiles! {
                obtain(item: textItem)
            }
            
            for mediaItem in folder.media! {
                obtain(item: mediaItem)
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
    
    /// получить максимальный id
    ///
    /// - Returns: максимальный id 
    func obtainLastId() -> Int {
        
        let folder = Array(dataManager.obtainFolders())
        let textFile = Array(dataManager.obtainTextFiles())
        let mediaFile = Array(dataManager.obtainMediaFiles())
        var id: [Int] = []
        
        for item in folder {
            id.append(item.id)
        }
    
        for item in textFile {
            id.append(item.id)
        }
        
        for item in mediaFile {
            id.append(item.id)
        }
        
        return id.max() ?? 0
    }
    
    /// Получить папку по id
    ///
    /// - Parameter id: id папки
    /// - Returns: папка с данным id
    func getFolderById(id: Int) -> FolderModel? {
        
        let items = dataManager.obtainFolders()
        
        for item in items {
            if item.id == id { return item }
        }
        
        return nil
    }
}
