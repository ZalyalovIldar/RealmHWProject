//
//  DataBaseManagerProtocol.swift
//  FileManager
//
//  Created by Гузель on 08/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import RealmSwift

protocol DataBaseManagerProtocol: AnyObject {

    /// Удаляет все данные из Realm
    ///
    /// - Returns: -
    func clearAll()
    
    /// Сохраняет объект в Realm
    ///
    /// - Parameter item: Объект который нужно сохранить
    /// - Returns: -
    func saveItem(item: Object)
    
    /// Удаляет определенный объект
    ///
    /// - Parameter item: Объект, который нужно удалить
    /// - Returns: -
    func removeItem(item: Object)
    
    /// Обновляет данные объекта, либо добавляет объект в бд если он не создан
    ///
    /// - Parameter item: Объект, который нужно обновить
    /// - Returns: -
    func updateItem(item: Object)
    
    /// Получение всех Папок
    ///
    /// - Returns: Массив папок
    func obtainFolders() -> [FolderModel]
    
    /// Получить все текстовые файлы
    ///
    /// - Returns: Массив текстовых файлов
    func obtainTextFiles() -> [TextFileModel]
    
    /// Получить все медиа файлы
    ///
    /// - Returns: Массив медиа файлов
    func obtainMediaFiles() -> [MediaModel]
    
    /// Выполнить транзакцию внутри блока write
    ///
    /// - Parameter transaction: транзакция
    func performTransaction(transaction: () -> ())
}
