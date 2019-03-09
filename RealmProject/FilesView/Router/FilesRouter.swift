//
//  FilesRouter.swift
//  RealmProject
//
//  Created by Петр on 27/02/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import UIKit

final class FilesRouter: FilesRouterInput, MediaPickerDelegate {
    
    /// View
    weak var view: FilesViewController!
    
    /// Presenter
    var filesPresenter: FilesRouterOutput!

    /// Media Picker
    var mediaPickerManager: MediaPickerManagerProtocol?
    
    var currentTitle: String?
    
    
    // MARK: - Files Router Input
    
    func showEnterTitleAlert(completionBlock: @escaping (String) -> Void) {
        
        let alert = UIAlertController(title: AlertTitles.AlertTitle.rawValue, message: nil, preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = ""
        }
        
        let cancelAction = UIAlertAction(title: AlertTitles.Cancel.rawValue, style: .default, handler: nil)
        let nextAction = UIAlertAction(title: AlertTitles.Next.rawValue, style: .default) { (alertAction) in
            
            if let title = alert.textFields![0].text {
                
                self.currentTitle = title
                completionBlock(title)
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(nextAction)
        view.present(alert, animated: true, completion: nil)
    }
    
    func showEnterNoteTitleAndTextAlert(completionBlock: @escaping (String, String) -> Void) {
        
        let alert = UIAlertController(title: AlertTitles.AlertTitle.rawValue, message: nil, preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = AlertTitles.TitlePlaceholder.rawValue
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = AlertTitles.TextPlaceholder.rawValue
        }
        
        let cancelAction = UIAlertAction(title: AlertTitles.Cancel.rawValue, style: .default, handler: nil)
        let nextAction = UIAlertAction(title: AlertTitles.Next.rawValue, style: .default) { (alertAction) in
            
            if let title = alert.textFields![0].text, let text = alert.textFields![1].text {
                
                completionBlock(title, text)
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(nextAction)
        view.present(alert, animated: true, completion: nil)
    }
    
    
    func showImagePicker(title: String?, type: MediaType) {
        mediaPickerManager?.showImagePicker(view: view, type: type)
    }
    
    
    // MARK: - Media Picker Delegate
    
    func handleSelectedImage(imageData: Data?) {
        filesPresenter.addPhoto(currentFolderId: self.view.currentFolderId, title: currentTitle, imageData: imageData)
    }
    
    func handleSelectedVideo(videoPath: String?) {
        filesPresenter.addVideo(currentFolderId: self.view.currentFolderId, title: currentTitle,videoPath: videoPath)
    }
}
