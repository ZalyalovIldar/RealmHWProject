//
//  FilesViewInput.swift
//  RealmProject
//
//  Created by Петр on 27/02/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation

protocol FilesViewInput: AnyObject {
    
    var currentFolderId: String? { get set }
    
    /// Set current folder
    func setFolder(folder: Folder?)
}
