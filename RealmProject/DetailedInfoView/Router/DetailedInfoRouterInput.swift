//
//  DetailedInfoRouterInput.swift
//  RealmProject
//
//  Created by Петр on 09/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation

protocol DetailedInfoRouterInput: AnyObject {
    
    /// Shows imagee picker to attach new photo
    ///
    /// - Parameter currentObjectId: current object identificator
    func showImagePicker(currentObjectId: String?, type: MediaType)
}
