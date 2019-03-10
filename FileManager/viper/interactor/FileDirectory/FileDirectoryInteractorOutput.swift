//
//  FileDirectoryInteractorOutput.swift
//  FileManager
//
//  Created by Гузель on 02/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation

protocol FileDirectoryInteractorOutput: AnyObject {
    
    func didFinishObtainingFolder(_ folder: FolderModel)
    
    func showMedia(item: MediaModel)
    
    func showText(item: TextFileModel)
    
    func showFolder(item: FolderModel)
    
    func initItem(item: FolderModel)
    
    func initCellWeight(text: String)
}
