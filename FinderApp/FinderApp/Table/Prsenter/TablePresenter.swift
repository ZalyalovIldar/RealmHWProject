//
//  TablePresenter.swift
//  FinderApp
//
//  Created by Александр Арсенюк on 26/02/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class TablePresenter: TableViewOutputProtocol {
    
    enum ImageSource {
        case photoLibrary
        case video
    }
    
    weak var view: TableViewInputProtocol!
    var dbManager: DataBaseManagerProtocol!
    var dataManager: OperationsWithDataProtocol!
    var imagePicker: ImagePickerMangaer!
    var alertManager: AlertManagerProtoclol!
    var tableViewController: TableViewController!
    
    func requestForNewFolder() {
        tableViewController.present(alertManager.createAlertWithOneTextFields(type: "folder", content: nil), animated: true, completion: nil)
    }
   
    func creteNewFolder(name: String, inFolderWithId: String) {
        
        let uuid = UUID().uuidString
        let newFolder = TypeOfObject()
        let currentDate = Date()
        let folderImageData = dataManager.archive(object: view.obtainFolderImage())
        let array = dbManager.obtaimModelsWithId(id: uuid)
        
        newFolder.id = uuid
        newFolder.name = name
        newFolder.picture = folderImageData
        newFolder.type = "folder"
        newFolder.dateOfCreate = currentDate
        newFolder.content = self.dataManager.archive(object: array)
        newFolder.folderId = inFolderWithId
        var models: [TypeOfObject]  = self.dbManager.obtaimModelsWithId(id: inFolderWithId)
        self.dbManager.save(model: newFolder)
        models.append(newFolder)
        view.updateTableView(models: models)
    }
   
    func requestForNewImage() {
       
        imagePicker.presentImagePicker(.photoLibrary)
    }
    
    func creteNewImage(name: String, imageData: Data, inFolderWithId: String) {
        
        let pictureImageData = dataManager.archive(object: view.obtainPictureImage())
        let newImage = TypeOfObject()
        let currentDate = Date()
        let uuid = UUID().uuidString
        
        newImage.id = uuid
        newImage.name = name
        newImage.type = "picture"
        newImage.picture = pictureImageData
        newImage.content = imageData
        newImage.dateOfCreate = currentDate
        newImage.folderId = inFolderWithId
        var models: [TypeOfObject]  = self.dbManager.obtaimModelsWithId(id: inFolderWithId)
        models.append(newImage)
        dbManager.save(model: newImage)
        view.updateTableView(models: models)
    }
    
    
    func  requestForNewVideo() {
        
        imagePicker.presentImagePicker(.video)
    }
    
    func creteNewVideo(name: String, playerData: Data, inFolderWithId: String) {
        
        let videoImageData = dataManager.archive(object: view.obtainVideoImage())
        let newVideo = TypeOfObject()
        let currentDate = Date()
        let uuid = UUID().uuidString
        
        newVideo.id = uuid
        newVideo.name = name
        newVideo.type = "video"
        newVideo.picture = videoImageData
        newVideo.content = playerData
        newVideo.dateOfCreate = currentDate
        newVideo.folderId = inFolderWithId
        var models: [TypeOfObject]  = self.dbManager.obtaimModelsWithId(id: inFolderWithId)
        models.append(newVideo)
        dbManager.save(model: newVideo)
        view.updateTableView(models: models)
    }
    
    func requestForNewNote() {
        
        tableViewController.present(alertManager.createAlertWithTwoTextFields(), animated: true, completion:  nil)
    }
    
    func creteNewNote(name: String, content: String, inFolderWithId: String) {
        
        let noteImageData = dataManager.archive(object: view.obtainNoteImage())
        let newNote = TypeOfObject()
        let currentDate = Date()
        let uuid = UUID().uuidString
        
        newNote.id = uuid
        newNote.name = name
        newNote.type = "note"
        newNote.picture = noteImageData
        newNote.content = dataManager.archive(object: content)
        newNote.dateOfCreate = currentDate
        newNote.folderId = inFolderWithId
        var models: [TypeOfObject]  = self.dbManager.obtaimModelsWithId(id: inFolderWithId)
        models.append(newNote)
        dbManager.save(model: newNote)
        view.updateTableView(models: models)
    }
}
