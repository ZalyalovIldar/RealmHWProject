//
//  TableViewInput.swift
//  FinderApp
//
//  Created by Александр Арсенюк on 26/02/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewInputProtocol: AnyObject  {
    
    /// ообновить тамблицу с новым масиовом
    ///
    /// - Parameter models: обновленный масив
    func updateTableView(models: [Any])
    
    /// получить иконку папки
    ///
    /// - Returns: иконка
    func obtainFolderImage() -> UIImage
    
    /// получить иконку картинки
    ///
    /// - Returns: иконка
    func obtainPictureImage() -> UIImage
    
    /// получить иконку видео
    ///
    /// - Returns: иконка
    func obtainVideoImage() -> UIImage
    
    /// получить иконку заметки
    ///
    /// - Returns: иконка
    func obtainNoteImage() -> UIImage
    
    /// получить таблицу
    ///
    /// - Returns: таблицу
    func obtainTableVIew() -> UITableView
 }


