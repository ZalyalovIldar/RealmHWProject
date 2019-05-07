//
//  FileDirectoryInput.swift
//  FileManager
//
//  Created by Гузель on 02/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation

protocol FileDirectoryInput: AnyObject {
    
    /// Инициализировать корневую папку
    ///
    /// - Parameter mainFolder: папка
    func initMainFolder(mainFolder: FolderModel)
    
    /// Инициализировать текущую папку
    ///
    /// - Parameter item: папка
    func initItem(item: FolderModel)
    
    /// Инициализировать вес ячейки
    ///
    /// - Parameter text: вес в текстовом виде
    func initCellWeight(text: String)
}
