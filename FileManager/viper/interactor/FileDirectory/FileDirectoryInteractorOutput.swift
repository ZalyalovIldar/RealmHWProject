//
//  FileDirectoryInteractorOutput.swift
//  FileManager
//
//  Created by Гузель on 02/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation

protocol FileDirectoryInteractorOutput: AnyObject {
    
    /// Инициализируем корневую папку
    ///
    /// - Parameter folder: папка
    func didFinishObtainingFolder(_ folder: FolderModel)
    
    /// Показать медиа файл
    ///
    /// - Parameter item: медиа файл
    func showMedia(item: MediaModel)
    
    /// Показать текст файл
    ///
    /// - Parameter item: текст файл
    func showText(item: TextFileModel)
    
    /// Показать папку
    ///
    /// - Parameter item: папка
    func showFolder(item: FolderModel)
    
    /// Инициализируем папку, в котором мы сейчас находимсся
    ///
    /// - Parameter item: папка, в котором мы находимся
    func initItem(item: FolderModel)
    
    /// отправляем вес для определенной ячейки
    ///
    /// - Parameter text: Вес в текстовом виде
    func initCellWeight(text: String)
}
