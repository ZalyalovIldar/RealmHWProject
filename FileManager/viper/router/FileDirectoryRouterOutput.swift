//
//  FileDirectoryRouterOutput.swift
//  FileManager
//
//  Created by Гузель on 02/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import RealmSwift

protocol FileDirectoryRouterOutput: AnyObject {
    
    func addNewItem(item: FolderModel, name: String?, type: String?)
    
    func editNameOfObject(_ item: Object, _ folder: FolderModel, _ textField: String?)
}
