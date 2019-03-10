//
//  DetailedInfoRouterOutput.swift
//  RealmProject
//
//  Created by Петр on 09/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation

protocol DetailedInfoRouterOutput: AnyObject {
    
    /// Reacts on add photo click
    ///
    /// - Parameters:
    ///   - currentObjectId: current object identificator
    ///   - imageData: image data
    func changePhoto(currentObjectId: String?, imageData: Data?)
    
    /// Reacts on add video click
    ///
    /// - Parameters:
    ///   - currentObjectId: current object identificator
    ///   - videoPath: path of the video
    func changeVideo(currentObjectId: String?, videoUrlPath: URL?)
    
}
