//
//  FileDirectoryRouterInput.swift
//  FileManager
//
//  Created by Гузель on 02/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import RealmSwift

protocol FileDirectoryRouterInput: AnyObject {
    
    func showAlert(item: FolderModel)
    
    func showFolder(item: FolderModel)
    
    func showText(item: TextFileModel)
    
    func showMedia(item: MediaModel)
    
    func showEditNameAlert(_ item: Object, _ folder: FolderModel)
}
