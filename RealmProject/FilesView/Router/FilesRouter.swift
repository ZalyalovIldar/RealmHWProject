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
    
    func showEnterTitleAlert(completionBlock: @escaping (String?) -> Void) {
        
        let alert = UIAlertController(title: AlertTitles.AlertTitle.rawValue, message: nil, preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = AlertTitles.TitlePlaceholder.rawValue
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
    
    
    func showEnterNoteTitleAndTextAlert(completionBlock: @escaping (String?, String?) -> Void) {
        
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
    
    
    func showEnterUrlAlert(completionBlock: @escaping (String?, String?) -> Void) {
        
        let alert = UIAlertController(title: AlertTitles.URLTitle.rawValue, message: nil, preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = AlertTitles.TitlePlaceholder.rawValue
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = AlertTitles.URLPlaceholder.rawValue
        }
        
        let cancelAction = UIAlertAction(title: AlertTitles.Cancel.rawValue, style: .default, handler: nil)
        let nextAction = UIAlertAction(title: AlertTitles.Next.rawValue, style: .default) { (alertAction) in
            
            if let title = alert.textFields![0].text, let urlString = alert.textFields![1].text {
                completionBlock(title, urlString)
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(nextAction)
        view.present(alert, animated: true, completion: nil)
    }
    
    
    func showErrorAlert(with title: String?) {
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: AlertTitles.Cancel.rawValue, style: .default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
    
    func showImagePreviewAlert(title: String?, imageData: Data?, imageUrlString: String?, completionBlock: @escaping (String?, ImageSaveMethod, String?) -> Void) {
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: UIAlertController.Style.alert)
        
        let image = UIImage(data: imageData!)
        
        alert.addImage(image: image!)
        
        alert.addAction(UIAlertAction(title: ImageSaveMethod.Cache.rawValue, style: .default) { (alertAction) in
            completionBlock(title, ImageSaveMethod.Cache, imageUrlString)
        })
        alert.addAction(UIAlertAction(title: ImageSaveMethod.Memory.rawValue, style: .default) { (alertAction) in
            completionBlock(title, ImageSaveMethod.Memory, nil)
        })
        alert.addAction(UIAlertAction(title: AlertTitles.Cancel.rawValue, style: .default, handler: nil))
        
        view.present(alert, animated: true, completion: nil)
    }
    
    
    func showImagePicker(title: String?, type: MediaType) {
        mediaPickerManager?.showImagePicker(in: view, type: type)
    }
    
    
    // MARK: - Media Picker Delegate
    
    func handleSelectedImage(imageData: Data?) {
        filesPresenter.addPhoto(currentFolderId: self.view.currentFolderId, title: currentTitle, imageData: imageData)
    }
    
    
    func handleSelectedVideo(videoUrlPath: URL?) {
        filesPresenter.addVideo(currentFolderId: self.view.currentFolderId, title: currentTitle, videoUrlPath: videoUrlPath)
    }
    
}
