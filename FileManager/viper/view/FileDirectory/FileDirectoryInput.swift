//
//  FileDirectoryInput.swift
//  FileManager
//
//  Created by Гузель on 02/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation

protocol FileDirectoryInput: AnyObject {
    
    func initMainFolder(mainFolder: FolderModel)
    
    func initItem(item: FolderModel)
    
    func initCellWeight(text: String)
}
