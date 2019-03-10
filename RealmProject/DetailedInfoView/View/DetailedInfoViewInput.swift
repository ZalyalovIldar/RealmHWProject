//
//  DetailedInfoViewInput.swift
//  RealmProject
//
//  Created by Петр on 08/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation

protocol DetailedInfoViewInput: AnyObject {
    
    /// Sets image data
    ///
    /// - Parameter imageData: image data
    func setImage(imageData: Data?, imageUrl: String?)
}
