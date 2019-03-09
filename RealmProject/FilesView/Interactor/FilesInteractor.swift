//
//  FilesInteractor.swift
//  RealmProject
//
//  Created by Петр on 27/02/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import RealmSwift

final class FilesInteractor: FilesInteractorInput {
 
    var databaseManager: DatabaseManagerProtocol!
    var filesPresenter: FilesInteractorOutput!

    func addNewFolder(folderId: String?, title: String?) {
        
        guard let currentFolderId = folderId, let title = title else { return }
        
        if let currentFolder = databaseManager.getObjects(with: Folder.self)?
            .filter({ $0.id == currentFolderId })
            .first {
        
            let newFolder = Folder()
            newFolder.title = title
            
            databaseManager.performTransaction {
                currentFolder.folders.append(newFolder)
            }
            
            filesPresenter.setFolder(folder: currentFolder)
        }
    }
    
    
    func addNewPhoto(folderId: String?, title: String?, imageData: Data?) {
        
        guard let currentFolderId = folderId, let title = title, let imageData = imageData
            else { return }
        
        if let currentFolder = databaseManager.getObjects(with: Folder.self)?
            .filter({ $0.id == currentFolderId })
            .first {
        
            let newPhoto = Photo()
            newPhoto.title = title
            newPhoto.imageData = imageData
            
            databaseManager.performTransaction {
                currentFolder.photos.append(newPhoto)
            }
            
            filesPresenter.setFolder(folder: currentFolder)
        }
    }

    
    func addNewVideo(folderId: String?, title: String?, videoPath: String?) {
        
        guard let currentFolderId = folderId, let title = title, let path = videoPath else { return }
        
        if let currentFolder = databaseManager.getObjects(with: Folder.self)?
            .filter({ $0.id == currentFolderId })
            .first {
        
            let newVideo = Video()
            newVideo.title = title
            newVideo.videoPath = path
            
            databaseManager.performTransaction {
                currentFolder.videos.append(newVideo)
            }
            
            filesPresenter.setFolder(folder: currentFolder)
        }
    }
    
    
    func addNewNote(folderId: String?, title: String?, text: String?) {
        
        guard let currentFolderId = folderId, let title = title, let text = text else { return }
        
        if let currentFolder = databaseManager.getObjects(with: Folder.self)?
            .filter({ $0.id == currentFolderId })
            .first {
        
            let newNote = Note()
            newNote.title = title
            newNote.text = text
            
            databaseManager.performTransaction {
                currentFolder.notes.append(newNote)
            }
            
            filesPresenter.setFolder(folder: currentFolder)
        }
    }
    
    
    func getFolder(with id: String?) {
        
        guard id != nil else { return }
        
        if let folder = databaseManager.getObjects(with: Folder.self)?.filter({ $0.id == id }) {
            
            guard let currentFolder = folder.first else { return }
            filesPresenter.setFolder(folder: currentFolder)
        }
    }
    
    func getRootFolder() {
        
        if let rootFolder = databaseManager.getObjects(with: Folder.self)?.first(where: { $0.isRootFolder == true }) {
            
            filesPresenter.setFolder(folder: rootFolder)
        }
        else {
            
            let rootFolder = Folder()
            rootFolder.isRootFolder = true
            databaseManager.saveObjects(objects: Array([rootFolder]))
            filesPresenter.setFolder(folder: rootFolder)
        }
    }
    
    func deleteObject(object: Object) {
        databaseManager.deleteObjects(objects: [object])
    }
}
