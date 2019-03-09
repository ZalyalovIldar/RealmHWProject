//
//  DetailedInfoInteractorInput.swift
//  RealmProject
//
//  Created by Петр on 08/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation

protocol DetailedInfoInteractorInput: AnyObject {
    
    /// Attaches new photo
    ///
    /// - Parameters:
    ///   - objectId: photo id
    ///   - imageData: image data
    func attachNewPhoto(objectId: String?, imageData: Data?)
    
    /// Attaches new video
    ///
    /// - Parameters:
    ///   - objectId: video id
    ///   - videoPath: video path from local storage
    func attachNewVideo(objectId: String?, videoPath: String?)
    
    /// Attaches new text
    ///
    /// - Parameters:
    ///   - objectId: note id
    ///   - text: new text
    func attachNewText(objectId: String?, text: String?)
}
