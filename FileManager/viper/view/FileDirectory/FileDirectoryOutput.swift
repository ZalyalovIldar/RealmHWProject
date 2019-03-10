//
//  FileDirectoryOutput.swift
//  FileManager
//
//  Created by Гузель on 02/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import RealmSwift

protocol FileDirectoryOutput: AnyObject {
    
    func showAlert(item: FolderModel)
    
    func getMainFolder()
    
    func showMedia(item: MediaModel) 
    
    func showText(item: TextFileModel)
    
    func showFolder(item: FolderModel)
    
    func obtainWeight(item: Object)
    
    func deleteItem(_ item: Object, _ folder: FolderModel)
    
    func showEditNameAlert(_ item: Object, _ folder: FolderModel)
}
