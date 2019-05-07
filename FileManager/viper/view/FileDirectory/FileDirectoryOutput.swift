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
    
    /// Показать алерт с создаваемым объектом
    ///
    /// - Parameter item: папка в котором находимся
    func showAlert(item: FolderModel)
    
    /// Получить корневую папку
    func getMainFolder()
    
    /// Показать медиа файл
    ///
    /// - Parameter item: медиа файл
    func showMedia(item: MediaModel)
    
    /// Показать текстовый файл
    ///
    /// - Parameter item: текст файл
    func showText(item: TextFileModel)
    
    /// Показать папку
    ///
    /// - Parameter item: Папка
    func showFolder(item: FolderModel)
    
    /// Получение веса ячейки
    ///
    /// - Parameter item: объект, вес которого хотим получить
    func obtainWeight(item: Object)
    
    /// Удалить объект
    ///
    /// - Parameters:
    ///   - item: удаляемый объект
    ///   - folder: Папка в которой мы находимся
    func deleteItem(_ item: Object, _ folder: FolderModel)
    
    /// Показать алерт для изменения названия объекта
    ///
    /// - Parameters:
    ///   - item: Объект, название котрого изменяем
    ///   - folder: Внутри какой папки мы находимся
    func showEditNameAlert(_ item: Object, _ folder: FolderModel)
}
