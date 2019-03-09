//
//  FilesInteractorOutput.swift
//  RealmProject
//
//  Created by Петр on 27/02/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation

protocol FilesInteractorOutput: AnyObject {
    
    /// Return folder in presenter
    ///
    /// - Parameter folder: retrived folder
    func setFolder(folder: Folder?)
    
    /// Gets root folder
    func getRootFolder()
}
