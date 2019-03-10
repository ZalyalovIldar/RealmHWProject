//
//  FilesInteractorInput.swift
//  RealmProject
//
//  Created by Петр on 27/02/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import RealmSwift

protocol FilesInteractorInput: AnyObject {
    
    /// Adds new folder in current folder
    ///
    /// - Parameters:
    ///   - folderId: current folder
    ///   - title: title of folder
    func addNewFolder(folderId: String?, title: String?)
    
    /// Adds new photo in current folder
    ///
    /// - Parameters:
    ///   - folderId: current folder
    ///   - title: title of folder
    func addNewPhoto(folderId: String?, title: String?, imageData: Data?)
    
    /// Creates new photo object
    ///
    /// - Parameters:
    ///   - folderId: folder identificator
    ///   - title: photo title
    ///   - urlString: image url
    func cacheNewPhoto(folderId: String?, title: String?, urlString: String?)
    
    /// Adds new video in current folder
    ///
    /// - Parameters:
    ///   - folderId: current folder
    ///   - title: title of folder
    func addNewVideo(folderId: String?, title: String?, videoUrlPath: URL?)
    
    /// Adds new note in current folder
    ///
    /// - Parameters:
    ///   - folderId: current folder
    ///   - title: title of folder
    func addNewNote(folderId: String?, title: String?, text: String?)

    /// Returns folder by given id
    ///
    /// - Parameter id: given id
    func getFolder(with id: String?)
    
    /// Finds root folder and set it
    func getRootFolder()
    
    /// Deletes object
    ///
    /// - Parameter object: given object
    func deleteObject(object: Object)

    /// Handles image
    ///
    /// - Parameter url: image url
    func handleImageWithURL(title: String?, url: URL?)
}
