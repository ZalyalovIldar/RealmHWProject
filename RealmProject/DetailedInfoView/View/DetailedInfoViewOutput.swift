//
//  DetailedInfoViewOutput.swift
//  RealmProject
//
//  Created by Петр on 08/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation

protocol DetailedInfoViewOutput: AnyObject {
 
    /// Attaches new photo to given object
    ///
    /// - Parameter currentObjectId: current object identificator
    func attachNewPhoto(photoId: String?)
    
    /// Attaches new video to given object
    ///
    /// - Parameter currentObjectId: current object identificator
    func attachNewVideo(videoId: String?)
    
    /// Attaches new video to given object
    ///
    /// - Parameter currentObjectId: current object identificator
    func attachNewText(noteId: String?, text: String?)
}
