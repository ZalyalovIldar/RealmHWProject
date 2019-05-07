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
    
    /// Показать алерт с выбором - создать папку/текст/медиа
    ///
    /// - Parameter item: внутри какой папки мы находимяс
    func showAlert(item: FolderModel)
    
    /// переход в папку
    ///
    /// - Parameter item: в какую папку переходим
    func showFolder(item: FolderModel)
    
    /// Показать текст файл
    ///
    /// - Parameter item: текст.файл который нужно показать
    func showText(item: TextFileModel)
    
    /// Показать медиа.файл
    ///
    /// - Parameter item: медиа.файл, который нужно показать
    func showMedia(item: MediaModel)
    
    /// Показать алерт для изменения названия
    ///
    /// - Parameters:
    ///   - item: объект, имя которого нужно изменить
    ///   - folder: внутри какой папки мы находимся
    func showEditNameAlert(_ item: Object, _ folder: FolderModel)
}
