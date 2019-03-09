//
//  FilesViewOutput.swift
//  RealmProject
//
//  Created by Петр on 27/02/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import RealmSwift

protocol FilesViewOutput: AnyObject {
    
    /// Handles add media
    ///
    /// - Parameter type: type description
    func handleAddMediaButtonPressed(type: MediaType)
    
    /// Reacts on add folder click
    func addFolder(folderId: String?)
    
    /// Reacts on add note click
    func addNote(folderId: String?)
    
    /// Gets data folders
    func getFolder(with id: String?)
    
    /// Gets data folders
    func getRootFolder()
    
    /// Deletes given object
    ///
    /// - Parameter object: <#object description#>
    func deleteObject(object: Object)

}
