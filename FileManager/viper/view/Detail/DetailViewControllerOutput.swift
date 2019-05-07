//
//  DetailViewControllerOutput.swift
//  FileManager
//
//  Created by Гузель on 02/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

protocol DetailViewControllerOutput: AnyObject {
    
    /// Сохранить путь изображения в бд
    ///
    /// - Parameters:
    ///   - path: пуьть изображения
    ///   - item: медиа файл объект
    /// - Returns: -
    func saveImage(_ path: String, item: Object)
    
    /// Обновить объект
    ///
    /// - Parameter item: объект
    /// - Returns: -
    func updateItem(item: Object)
    
    /// Выполнить транзакцию внутри блока write
    ///
    /// - Parameter transaction: транзакция
    func performTransaction(transaction: () -> ())
}
