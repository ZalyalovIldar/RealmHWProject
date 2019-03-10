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
    var networkManager: NetworkManagerProtocol!
    
    /// File manager
    let fileManager = FileManager.default

    /// Cache
    lazy var cachedDataSource: NSCache<AnyObject, UIImage> = {
        return NSCache<AnyObject, UIImage>()
    }()
    
    
    // MARK: - Adding
    
    func addNewFolder(folderId: String?, title: String?) {
        
        guard let currentFolderId = folderId, let title = title else { return }
        
        if let currentFolder = databaseManager
            .getObjects(with: Folder.self)?
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
        
        if let currentFolder = databaseManager
            .getObjects(with: Folder.self)?
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
    
    func cacheNewPhoto(folderId: String?, title: String?, urlString: String?) {
        
        guard let currentFolderId = folderId, let title = title, let urlString = urlString
            else { return }
        
        if let currentFolder = databaseManager
            .getObjects(with: Folder.self)?
            .filter({ $0.id == currentFolderId })
            .first {
            
            let newPhoto = Photo()
            newPhoto.title = title
            newPhoto.imageUrl = urlString
            
            databaseManager.performTransaction {
                currentFolder.photos.append(newPhoto)
            }
            
            filesPresenter.setFolder(folder: currentFolder)
        }
        
    }

    
    func addNewVideo(folderId: String?, title: String?, videoUrlPath: URL?) {
        
        guard let currentFolderId = folderId, let title = title, let path = videoUrlPath else { return }
        
        let newVideoPath = URL(fileURLWithPath: videoDirectoryPath).appendingPathComponent(UUID.init().uuidString).appendingPathExtension("mov")
        
        do {
            try fileManager.moveItem(at: path, to: newVideoPath)
        }
        catch {
            print(error)
            return
        }
        
        if let currentFolder = databaseManager
            .getObjects(with: Folder.self)?
            .filter({ $0.id == currentFolderId })
            .first {
        
            let newVideo = Video()
            newVideo.title = title
            newVideo.videoPath = newVideoPath.pathComponents.last!
            
            databaseManager.performTransaction {
                currentFolder.videos.append(newVideo)
            }
            
            filesPresenter.setFolder(folder: currentFolder)
        }
    }
    
    
    func addNewNote(folderId: String?, title: String?, text: String?) {
        
        guard let currentFolderId = folderId, let title = title, let text = text else { return }
        
        if let currentFolder = databaseManager
            .getObjects(with: Folder.self)?
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
    
    
    // MARK: - Folders
    
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
    
    
    // MARK: - Object's deletion
    
    func deleteObject(object: Object) {
        databaseManager.deleteObjects(objects: [object])
    }
    
    
    // MARK: - Network
    
    func handleImageWithURL(title: String?, url: URL?) {
        
        guard let newTitle = title, let url = url else { return }
        
        networkManager.obtainImage(with: url) { (result) in
            
            switch result {
                
            case .Success(let data):
                self.filesPresenter.showImagePreviewAlert(title: newTitle, imageData: data, imageUrlString: url.absoluteString)
            
            case .Error(let error):
                self.filesPresenter.showErrorAlert(with: error.localizedLowercase)
            }
        }
    }
}
