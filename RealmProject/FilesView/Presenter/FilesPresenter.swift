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
            
            guard let currentTitle = title else { return }
            self.filesRouter.showImagePicker(title: currentTitle, type: type)
        }
    }
    
    
    func handleAddImageUsingURL(folderId: String?) {
        
        filesRouter.showEnterUrlAlert(completionBlock: { (title, urlString) in
            
            guard let currentTitle = title, let url = urlString, let imageUrl = URL(string: url)
                else { return }
            self.filesInteractor.handleImageWithURL(title: currentTitle, url: imageUrl)
        })
    }
    
    
    func addFolder(folderId: String?) {
        
        filesRouter.showEnterTitleAlert { (title) in
            
            guard let currentTitle = title else { return }
            self.filesInteractor.addNewFolder(folderId: folderId, title: currentTitle)
        }
    }
   
    
    func addNote(folderId: String?) {
        
        filesRouter.showEnterNoteTitleAndTextAlert { (title, text) in
            
            guard let currentTitle = title, let currentText = text else { return }
            self.filesInteractor.addNewNote(folderId: folderId, title: currentTitle, text: currentText)
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
    
    
    func addVideo(currentFolderId: String?, title: String?, videoUrlPath: URL?) {
        self.filesInteractor.addNewVideo(folderId: currentFolderId, title: title, videoUrlPath: videoUrlPath)
    }
    
    
    // MARK: - Files Interactor Output
    
    func setFolder(folder: Folder?) {
        
        guard folder != nil else { return }
        view.setFolder(folder: folder)
    }
    
    
    func showImagePreviewAlert(title: String?, imageData: Data?, imageUrlString: String?) {
        
        guard title != nil, let folderId = self.view.currentFolderId  else { return }
        
        filesRouter.showImagePreviewAlert(title: title, imageData: imageData, imageUrlString: imageUrlString) {[weak self] (title, method, urlString) in
            
            switch method {
                
            case .Memory:
                self?.filesInteractor.addNewPhoto(folderId: folderId, title: title, imageData: imageData)
        
            case .Cache:
                
                guard urlString != nil else { return }
                self?.filesInteractor.cacheNewPhoto(folderId: folderId, title: title, urlString: urlString)
            }
        }
    }
    
    
    func showErrorAlert(with title: String?) {
        
        guard let currentTitle = title else { return }
        filesRouter.showErrorAlert(with: currentTitle)
    }
    
}
