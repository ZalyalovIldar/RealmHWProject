//
//  DetailedInfoPresenter.swift
//  RealmProject
//
//  Created by Петр on 08/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation

class DetailedInfoPresenter:
    DetailedInfoViewOutput,
    DetailedInfoRouterOutput,
    DetailedInfoInteractorOutput {
    
    var detailedInfoRouter: DetailedInfoRouterInput!
    var detailedInfoInteractor: DetailedInfoInteractorInput!
    var view: DetailedInfoViewInput!
    
    
    // MARK: - View Output
    
    func attachNewPhoto(photoId: String?) {
        detailedInfoRouter.showImagePicker(currentObjectId: photoId, type: .Photo)
    }
    
    func attachNewVideo(videoId: String?) {
        detailedInfoRouter.showImagePicker(currentObjectId: videoId, type: .Video)
    }
    
    func attachNewText(noteId: String?, text: String?) {
        detailedInfoInteractor.attachNewText(objectId: noteId, text: text)
    }
    
    
    // MARK: - Router Output
    
    func changePhoto(currentObjectId: String?, imageData: Data?) {
        detailedInfoInteractor.attachNewPhoto(objectId: currentObjectId, imageData: imageData)
    }
    
    func changeVideo(currentObjectId: String?, videoPath: String?) {
        detailedInfoInteractor.attachNewVideo(objectId: currentObjectId, videoPath: videoPath)
    }
}
