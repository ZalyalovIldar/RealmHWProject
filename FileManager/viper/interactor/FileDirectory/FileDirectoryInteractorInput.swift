//
//  FileDirectoryInteractorInput.swift
//  FileManager
//
//  Created by Гузель on 02/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import RealmSwift

protocol FileDirectoryInteractorInput: AnyObject {
    
    func addNewItemToDirectory(item: FolderModel?, name: String?, type: String?)
    
    func getMainFolder()
    
    func didFinishObtainingFolder(_ folder: FolderModel)
    
    func showSelectedItem(item: CustomTableViewCell)
    
    func getFolderByName(_ name: String) -> Any?
    
    func deleteItem(_ item: Object, _ folder: FolderModel)
    
    func editNameOfObject(_ item: Object, _ folder: FolderModel, _ textField: String?)
    
    func obtainWeight(item: Object)
}
