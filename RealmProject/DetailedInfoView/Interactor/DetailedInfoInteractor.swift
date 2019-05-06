//
//  DetailedInfoInteractor.swift
//  RealmProject
//
//  Created by Петр on 08/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation

class DetailedInfoInteractor: DetailedInfoInteractorInput {
 
    var networkManager: NetworkManagerProtocol!
    var databaseManager: DatabaseManagerProtocol!
    var detailedInfoPresenter: DetailedInfoInteractorOutput!
    
    
    // MARK: - Interactor Input
    
    func attachNewPhoto(objectId: String?, imageData: Data?) {
        
        guard let currentObjectId = objectId, let data = imageData else { return }
        
        if let currentPhoto = databaseManager
            .getObjects(with: Photo.self)?
            .filter({ $0.id == currentObjectId })
            .first{

            databaseManager.performTransaction {
                currentPhoto.imageData = data
            }
        }
    }
    
    func attachNewVideo(objectId: String?, videoUrlPath: URL?) {
        
        guard let currentObjectId = objectId, let path = videoUrlPath else { return }
        
        if let currentVideo = databaseManager
            .getObjects(with: Video.self)?
            .filter({ $0.id == currentObjectId })
            .first{
            
            databaseManager.performTransaction {
                currentVideo.videoPath = path.absoluteString
            }
        }
    }
    
    func attachNewText(objectId: String?, text: String?) {
        
        guard let currentObjectId = objectId, let text = text else { return }
        
        if let currentNote = databaseManager
            .getObjects(with: Note.self)?
            .filter({ $0.id == currentObjectId })
            .first{
            
            databaseManager.performTransaction {
                currentNote.text = text
            }
        }
    }
    
    func getImage(url: String?) {
        
        guard let urlString = url, let currentUrl = URL(string: urlString) else { return }
        
        
    }
}
