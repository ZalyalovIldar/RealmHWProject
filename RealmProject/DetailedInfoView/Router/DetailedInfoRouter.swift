//
//  DetailedInfoRouter.swift
//  RealmProject
//
//  Created by Петр on 09/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation

class DetailedInfoRouter: DetailedInfoRouterInput, MediaPickerDelegate {
    
    /// View
    weak var view: DetailedInfoViewController!
    
    /// Presenter
    var detailedInfoPresenter: DetailedInfoRouterOutput!
    
    /// Media Picker
    var mediaPickerManager: MediaPickerManagerProtocol?
    
    /// Current object id
    var currentObjectId: String?
    
    
    // MARK: - Detailed Info Router Input
    
    func showImagePicker(currentObjectId: String?, type: MediaType) {
        
        guard currentObjectId != nil else { return }
        
        self.currentObjectId = currentObjectId
        mediaPickerManager?.showImagePicker(view: view, type: .Photo)
    }
    
    
    // MARK: - Media Picker Delegate
    
    func handleSelectedImage(imageData: Data?) {
        detailedInfoPresenter.changePhoto(currentObjectId: self.currentObjectId, imageData: imageData)
    }
    
    func handleSelectedVideo(videoPath: String?) {
        detailedInfoPresenter.changeVideo(currentObjectId: self.currentObjectId, videoPath: videoPath)
    }
}
