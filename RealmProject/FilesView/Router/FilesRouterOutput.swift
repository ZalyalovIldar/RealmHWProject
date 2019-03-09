//
//  FilesRouterOutput.swift
//  RealmProject
//
//  Created by Петр on 01/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation

protocol FilesRouterOutput: AnyObject {
    
    /// Reacts on add photo click
    func addPhoto(currentFolderId: String?, title: String?, imageData: Data?)
    
    /// Reacts on add video click
    func addVideo(currentFolderId: String?, title: String?, videoPath: String?)
}
