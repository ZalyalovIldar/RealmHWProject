//
//  FilesRouterInput.swift
//  RealmProject
//
//  Created by Петр on 27/02/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import UIKit

protocol FilesRouterInput: AnyObject {
    
    /// Shows error alert
    ///
    /// - Parameter title: given title
    func showErrorAlert(with title: String?) -> Void
    
    /// Calls alert with textfield for title
    ///
    /// - Parameter type: selected type of file
    func showEnterTitleAlert(completionBlock: @escaping (String?) -> Void)
    
    /// Calls alert with textfield for title
    ///
    /// - Parameter type: selected type of file
    func showEnterNoteTitleAndTextAlert(completionBlock: @escaping (String?, String?) -> Void)
    
    /// Shows alert to enter url of the image
    ///
    /// - Parameter completionBlock: to obtain url 
    func showEnterUrlAlert(completionBlock: @escaping (String?, String?) -> Void)
    
    /// Image preview for saving
    ///
    /// - Parameters:
    ///   - title: title of image
    ///   - imageData: image data
    ///   - imageUrlString: image url
    ///   - completionBlock: detect selected method
    func showImagePreviewAlert(
        title: String?,
        imageData: Data?,
        imageUrlString: String?,
        completionBlock: @escaping (String?, ImageSaveMethod, String?) -> Void)
    
    /// Shows image picker
    func showImagePicker(title: String?, type: MediaType)
}
