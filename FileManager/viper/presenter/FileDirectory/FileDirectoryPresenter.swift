//
//  FileDirectoryPresenter.swift
//  FileManager
//
//  Created by Гузель on 02/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import RealmSwift

class FileDirectoryPresenter: FileDirectoryOutput, FileDirectoryRouterOutput, FileDirectoryInteractorOutput {

    var router: FileDirectoryRouterInput!
    var interactor: FileDirectoryInteractorInput!
    var view: FileDirectoryInput!
    
    //1
    func showAlert(item: FolderModel) {
        router.showAlert(item: item)
    }
    
    //2
    func addNewItem(item: FolderModel, name: String?, type: String?) {
        interactor.addNewItemToDirectory(item: item, name: name, type: type)
    }
    
    //1
    func getMainFolder() {
        interactor.getMainFolder()
    }
    //4
    func didFinishObtainingFolder(_ folder: FolderModel) {
        view.initMainFolder(mainFolder: folder)
    }
    
    func showMedia(item: MediaModel) {
        router.showMedia(item: item)
    }
    
    func showText(item: TextFileModel) {
        router.showText(item: item)
    }
    
    func showFolder(item: FolderModel) {
        router.showFolder(item: item)
    }
    
    //3
    func initItem(item: FolderModel) {
        view.initItem(item: item)
    }
    
    func deleteItem(_ item: Object, _ folder: FolderModel) {
        interactor.deleteItem(item, folder)
    }
    
    func editNameOfObject(_ item: Object, _ folder: FolderModel, _ textField: String?) {
        interactor.editNameOfObject(item, folder, textField)
    }
    
    func showEditNameAlert(_ item: Object, _ folder: FolderModel) {
        router.showEditNameAlert(item, folder)
    }
    
    //4
    func obtainWeight(item: Object) {
        interactor.obtainWeight(item: item)
    }
    
    //6
    func initCellWeight(text: String) {
        view.initCellWeight(text: text)
    }
    
}
