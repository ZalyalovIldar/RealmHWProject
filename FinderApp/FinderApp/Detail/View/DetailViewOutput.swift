//
//  DetailViewOutput.swift
//  FinderApp
//
//  Created by Александр Арсенюк on 26/02/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation

protocol DetailViewOutputProtocol: AnyObject {
    
    /// разархивровать входящую data
    ///
    /// - Parameter model: модель в которой будет меняться data
    func unarchiveIncomingData(model: TypeOfObject)
    
    /// редактирование контента
    ///
    /// - Parameter model: модель которую редачим
    func editContent(model: TypeOfObject)
    
    /// измениеи имени
    ///
    /// - Parameter model: модель в которой меняется имя
    func editName(model: TypeOfObject)
    
    /// установить новое имя
    ///
    /// - Parameters:
    ///   - name: имя которое надо установить
    ///   - model: модель в которой устанваливаем имя
    func setNewName(name: String, model: TypeOfObject)
    
    /// устанвоить новый контекст заметки
    ///
    /// - Parameters:
    ///   - name: контекст заметки
    ///   - model: модельв которйо меняется контекст (заметки only)
    func setNewTextContent(name: String, model: TypeOfObject)
}
