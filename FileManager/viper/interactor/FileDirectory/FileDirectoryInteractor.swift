//
//  FileDirectoryInteractor.swift
//  FileManager
//
//  Created by Гузель on 02/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import RealmSwift

enum Type: String {
    
    case _empty = "", folder = "folder", text = "text", image = "image", video = "video", media = "media"
}

class FileDirectoryInteractor: FileDirectoryInteractorInput {
    
    var dataManager: DataBaseManagerProtocol!
    var presenter: FileDirectoryInteractorOutput!
    var items: [Any] = []
    
    
    func addNewItemToDirectory(item: FolderModel?, name: String?, type: String?) {
        
        if name != nil && type != nil {
            
            switch type {
                
            case (Type.folder).rawValue:
                
                let folderModel = FolderModel()
                folderModel.name = name!
                folderModel.time = Date()
                if(item == nil) {
                    folderModel.name = "FileDirectory"
                    folderModel.id = 1
                    dataManager.saveItem(item: folderModel)
                } else {
                    var currentFolder = FolderModel()
                    currentFolder = dataManager.getFolderById(id: (item?.id)!)!
                    folderModel.id = dataManager.obtainLastId() + 1
                    dataManager.performTransaction {
                        currentFolder.folders?.append(folderModel)
                    }
                    dataManager.updateItem(item: currentFolder)
                    dataManager.updateItem(item: folderModel)
                    presenter.initItem(item: currentFolder)
                }
            case (Type.text).rawValue:
                
                var currentFolder = FolderModel()
                currentFolder = dataManager.getFolderById(id: (item?.id)!)!
                let textFileModel = TextFileModel()
                textFileModel.name = name!
                textFileModel.time = Date()
                textFileModel.id = dataManager.obtainLastId() + 1
                dataManager.performTransaction {
                    currentFolder.textFiles?.append(textFileModel)
                }
                dataManager.saveItem(item: currentFolder)
                presenter.initItem(item: currentFolder)
            case (Type.image).rawValue:
                
                var currentFolder = FolderModel()
                currentFolder = dataManager.getFolderById(id: (item?.id)!)!
                let mediaModel = MediaModel()
                mediaModel.name = name!
                mediaModel.time = Date()
                mediaModel.id = dataManager.obtainLastId() + 1
                dataManager.performTransaction {
                    currentFolder.media?.append(mediaModel)
                }
                dataManager.saveItem(item: currentFolder)
                presenter.initItem(item: currentFolder)
            case (Type.video).rawValue:
                
                var currentFolder = FolderModel()
                currentFolder = dataManager.getFolderById(id: (item?.id)!)!
                let mediaModel = MediaModel()
                mediaModel.name = name!
                mediaModel.time = Date()
                mediaModel.id = dataManager.obtainLastId() + 1
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
        dataManager.deleteItem(item, folder)
    }
    
    func editNameOfObject(_ item: Object, _ folder: FolderModel, _ textField: String?) {
        dataManager.editNameOfObject(item, folder, textField)
    }
    
    //исправить
    func showSelectedItem(item: CustomTableViewCell) {
        
        switch item.typeLabel.text {
            
        case (Type.folder).rawValue:
            
            let currentFolder = getFolderByName(item.nameLabel.text!)
            presenter.showFolder(item: currentFolder as! FolderModel)
        case (Type.text).rawValue:
            
            let currentTextFile = getTextFileByName(item.nameLabel.text!)
            presenter.showText(item: currentTextFile as! TextFileModel)
        case (Type.image).rawValue:
            
            let currentMediaFile = getMediaFileByName(item.nameLabel.text!)
            presenter.showMedia(item: currentMediaFile as! MediaModel)
        case (Type.video).rawValue:
            
            let currentMediaFile = getMediaFileByName(item.nameLabel.text!)
            presenter.showMedia(item: currentMediaFile as! MediaModel)
        default:
            break
        }
    }
    
    //2
    func getMainFolder() {
        var mainFolder: FolderModel! = dataManager.getFolderById(id: 1)
        if mainFolder == nil {
            addNewItemToDirectory(item: nil, name: "FileDirectory", type: (Type.folder).rawValue)
            mainFolder = dataManager.getFolderById(id: 1)
        }
        presenter.didFinishObtainingFolder(mainFolder!)
    }
    
    func getFolderByName(_ name: String) -> Any? {
        let folders = dataManager.obtainFolders()
        for main in Array(folders) {
            if main.name == name {
                return main
            }
        }
        return nil
    }
    
    func getTextFileByName(_ name: String) -> Any? {
        let items = dataManager.obtainTextFiles()
        for item in Array(items) {
            if item.name == name {
                return item
            }
        }
        return nil
    }
    
    func getMediaFileByName(_ name: String) -> Any? {
        let items = dataManager.obtainMediaFiles()
        for item in Array(items) {
            if item.name == name {
                return item
            }
        }
        return nil
    }
    
    //5
    func obtainWeight(item: Object) {
        let weight = dataManager.obtainWeight(item: item)
        if weight != 0.0 {
            presenter.initCellWeight(text: String(format: "%.3f", weight))
        } else {
            presenter.initCellWeight(text: String(0))
        }
    }
    
}
