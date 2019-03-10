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
    
    /// Handles adding image using web url
    ///
    /// - Parameter folderId: current folder id
    func handleAddImageUsingURL(folderId: String?)
    
    /// Reacts on add folder click
    ///
    /// - Parameter folderId:  current folder id
    func addFolder(folderId: String?)
    
    /// Reacts on add note click
    ///
    /// - Parameter folderId:  current folder id
    func addNote(folderId: String?)
    
    /// Gets data folders
    ///
    /// - Parameter id: folder id
    func getFolder(with id: String?)
    
    /// Gets data folders
    func getRootFolder()
    
    /// Deletes given object
    ///
    /// - Parameter object: given object
    func deleteObject(object: Object)

}
