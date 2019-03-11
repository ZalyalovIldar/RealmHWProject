//
//  DetailInteractorInput.swift
//  FileManager
//
//  Created by Гузель on 10/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

protocol DetailInteractorInput: AnyObject {
    
    /// Сохранить изображение в бд
    ///
    /// - Parameters:
    ///   - path: путь изображения
    ///   - item: медиа.файл с изображением
    /// - Returns: -
    func saveImage(_ path: String, item: Object)
    
    /// Обновить объект
    ///
    /// - Parameter item: объект, который нужно обновить
    /// - Returns: -
    func updateItem(item: Object)
    
    /// Выполнить транзакцию внутри блока write
    ///
    /// - Parameter transaction: транзакция
    func performTransaction(transaction: () -> ())
}
