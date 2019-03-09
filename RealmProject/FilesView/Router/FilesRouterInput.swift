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
    
    /// Call alert with textfield for title
    ///
    /// - Parameter type: selected type of file
    func showEnterTitleAlert(completionBlock: @escaping (String) -> Void)
    
    /// Call alert with textfield for title
    ///
    /// - Parameter type: selected type of file
    func showEnterNoteTitleAndTextAlert(completionBlock: @escaping (String, String) -> Void)
    
    /// Shows image picker
    func showImagePicker(title: String?, type: MediaType)
}
