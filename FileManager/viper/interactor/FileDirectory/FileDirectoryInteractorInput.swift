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
    
    /// Добавить новый элемент в бд
    ///
    /// - Parameters:
    ///   - item: внутри какой папки мы находимся
    ///   - name: название нового объекта
    ///   - type: тип нового объекта
    func addNewItemToDirectory(item: FolderModel?, name: String?, type: String?)
    
    /// Получить корневую папку
    func getMainFolder()
    
    /// Инициализируем корневую папку
    ///
    /// - Parameter folder: корневая папка
    func didFinishObtainingFolder(_ folder: FolderModel)
    
    /// Удаляем объект
    ///
    /// - Parameters:
    ///   - item: объект, который надо удалить
    ///   - folder: внутри какой папки мы находитмся
    func deleteItem(_ item: Object, _ folder: FolderModel)
    
    /// Изменить название объекта
    ///
    /// - Parameters:
    ///   - item: объект, название которого меняем
    ///   - folder: Внутри какой папки мы находимся
    ///   - textField: Новое название
    func editNameOfObject(_ item: Object, _ folder: FolderModel, _ textField: String?)
    
    /// Получить размеры данного объекта
    ///
    /// - Parameter item: объект, вес которого надо узнать
    func obtainWeight(item: Object)
}
