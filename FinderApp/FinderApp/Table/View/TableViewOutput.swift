//
//  TableViewOutput.swift
//  FinderApp
//
//  Created by Александр Арсенюк on 26/02/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewOutputProtocol: AnyObject {
    
    /// создать новую папку
    ///
    /// - Parameters:
    ///   - name: имя
    ///   - inFolderWithId: папка в которой создать
    func creteNewFolder(name: String, inFolderWithId: String)
    
    /// создать новую картинку
    ///
    /// - Parameters:
    ///   - name: имя кратинки
    ///   - imageData: сама картинка
    ///   - inFolderWithId: папка в которой создается
    func creteNewImage(name: String, imageData: Data, inFolderWithId: String)
    
    /// создать новый виде
    ///
    /// - Parameters:
    ///   - name: имя видео
    ///   - playerData: само видео
    ///   - inFolderWithId: папка в которой надо создать
    func creteNewVideo(name: String, playerData: Data, inFolderWithId: String)
    
    /// создать новую заметку
    ///
    /// - Parameters:
    ///   - name: имя заметки
    ///   - content: текст заметки
    ///   - inFolderWithId: папка в которой создается
    func creteNewNote(name: String, content: String, inFolderWithId: String)
    
    /// запрос на создание папки
    func requestForNewFolder()
    
    /// запрос на создание картингки
    func requestForNewImage()
    
    /// запрос на создание видео
    func requestForNewVideo()
    
    /// запрос на создание заметки
    func requestForNewNote()
}
