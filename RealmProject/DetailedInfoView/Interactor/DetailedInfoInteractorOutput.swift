//
//  DetailedInfoInteractorOutput.swift
//  RealmProject
//
//  Created by Петр on 08/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation

protocol DetailedInfoInteractorOutput: AnyObject {
    
    /// Handles dowloaded image in interactor
    ///
    /// - Parameter imageData: image data
    /// - Parameter imageUrl: image url
    func setImage(imageData: Data?, imageUrl: String?)
}
