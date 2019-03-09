//
//  FilesPresenter.swift
//  RealmProject
//
//  Created by Петр on 27/02/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import RealmSwift

final class FilesPresenter: FilesViewOutput, FilesInteractorOutput, FilesRouterOutput {    
    
    var filesRouter: FilesRouterInput!
    var filesInteractor: FilesInteractorInput!
    var view: FilesViewInput!

    
    // MARK: - Files View Output
    
    func handleAddMediaButtonPressed(type: MediaType) {
        
        filesRouter.showEnterTitleAlert { (title) in
            self.filesRouter.showImagePicker(title: title, type: type)
        }
    }    
    
    
    func addFolder(folderId: String?) {
        
        filesRouter.showEnterTitleAlert { (title) in
            self.filesInteractor.addNewFolder(folderId: folderId, title: title)
        }
    }
    
    func addNote(folderId: String?) {
        
        filesRouter.showEnterNoteTitleAndTextAlert { (title, text) in
            self.filesInteractor.addNewNote(folderId: folderId, title: title, text: text)
        }
    }
    
    
    func getRootFolder() {
        filesInteractor.getRootFolder()
    }
    
    func getFolder(with id: String?) {
        filesInteractor.getFolder(with: id)
    }
    
    
    func deleteObject(object: Object) {
        filesInteractor.deleteObject(object: object)
    }
    
    
    // MARK: - Files Router Output
    
    func addPhoto(currentFolderId: String? , title: String?, imageData: Data?) {
        self.filesInteractor.addNewPhoto(folderId: currentFolderId, title: title, imageData: imageData)
    }
    
    func addVideo(currentFolderId: String?, title: String?, videoPath: String?) {
        self.filesInteractor.addNewVideo(folderId: currentFolderId, title: title, videoPath: videoPath)
    }
    
    
    // MARK: - Files Interactor Output
    
    func setFolder(folder: Folder?) {
        
        guard folder != nil else { return }
        view.setFolder(folder: folder)
    }
}
