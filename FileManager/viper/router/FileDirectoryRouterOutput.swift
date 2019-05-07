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
    
    /// Добавить новый объект
    ///
    /// - Parameters:
    ///   - item: внутри какой папки находимся
    ///   - name: название нового объекта
    ///   - type: тип нового объекта
    func addNewItem(item: FolderModel, name: String?, type: String?)
    
    /// Изменить название объекта
    ///
    /// - Parameters:
    ///   - item: объект, имя которого нужно изменить
    ///   - folder: внутри какой папки мы находимся
    ///   - textField: Новое название
    func editNameOfObject(_ item: Object, _ folder: FolderModel, _ textField: String?)
}
