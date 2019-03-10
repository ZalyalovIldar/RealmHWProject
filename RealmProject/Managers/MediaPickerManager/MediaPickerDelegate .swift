//
//  MediaPickerDelegate .swift
//  RealmProject
//
//  Created by Петр on 06/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation

protocol MediaPickerDelegate {
    
    /// Handles selected image
    ///
    /// - Parameter imageData: image's data
    func handleSelectedImage(imageData: Data?)
   
    /// Handles selected image
    ///
    /// - Parameter imageData: image's data
    func handleSelectedVideo(videoUrlPath: URL?)
}
