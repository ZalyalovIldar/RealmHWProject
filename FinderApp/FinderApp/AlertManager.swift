//
//  AlertManager.swift
//  FinderApp
//
//  Created by Александр Арсенюк on 02/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import UIKit

/// протокол работы с алертами
protocol AlertManagerProtoclol {
    
    /// создает алерт с двумя текс филдами для создании новой папки
    ///
    /// - Returns: алерт
    func createAlertWithTwoTextFields() -> UIAlertController
    
    /// создает алерт с одним текс филдом
    ///
    /// - Parameters:
    ///   - type: тип создаваемого объекта
    ///   - content: контент создаваемого объекта
    /// - Returns: алерт
    func createAlertWithOneTextFields(type: String, content: Any?) -> UIAlertController
    
    /// алерт для смены имени
    ///
    /// - Parameter model: модель у которой меняем имя
    /// - Returns: алерт
    func changeNameAlert(model: TypeOfObject) -> UIAlertController
    
    /// алерт изменения
    ///
    /// - Parameter model: модель у которой меняем текстовое содержаени(только текс ноуты)
    /// - Returns: алерт
    func changeTextContenteAlert(model: TypeOfObject) -> UIAlertController
}

class AlertManager: AlertManagerProtoclol {
    
    var presenter: TableViewOutputProtocol!
    var detailPresenter: DetailViewOutputProtocol!
    weak var view: TableViewController!
    
    let enterNameConstant = "Enter the name"
    let enterTextConstant = "Enter the text"
    let fillFieldsConstant = "Fill all fields"
    let noteTitle = "New Note"
    let fileTitle = "New File"
    let nameTitle = "New Name"
    let editingTitle = "Editing note"
    let editingMessage = "Put your new note here"
    let OkConstant = "OK"
    let emptyConstant = ""
    let folderType = "folder"
    let imageType = "image"
    let videoType = "video"
    let twoFiledsNameConstant = 0
    let twoFiledsContentConstant = 1
    let oneFiledsNameConstant = 2
    let changeTwoFiledsNameConstant = 01
    let changeTwoFiledsContentConstant = 11
    
    
    func createAlertWithTwoTextFields() -> UIAlertController {
        let alert = UIAlertController(title: noteTitle, message: fillFieldsConstant, preferredStyle: .alert)
        alert.addTextField { (nameTextField) in
            nameTextField.text = self.emptyConstant
            nameTextField.placeholder = self.enterNameConstant
            nameTextField.tag = self.twoFiledsNameConstant
        }
        alert.addTextField { (contentTextField) in
            contentTextField.text = self.emptyConstant
            contentTextField.placeholder = self.enterTextConstant
            contentTextField.tag = self.twoFiledsContentConstant
        }
        alert.addAction(UIAlertAction(title: OkConstant, style: .default, handler: { [weak alert] (_) in
            
            var name = String()
            var content = String()
            
            for textField in alert!.textFields! {
                if let nameTextField = textField.viewWithTag(self.twoFiledsNameConstant) as? UITextField {
                    name = nameTextField.text!
                }
                if let contentTextField = textField.viewWithTag(self.twoFiledsContentConstant) as? UITextField {
                    content = contentTextField.text!
                }
            }
            self.presenter.creteNewNote(name: name, content: content, inFolderWithId: self.view.currentFolder.id)
        }))
        return alert
    }
    
    func createAlertWithOneTextFields(type: String, content: Any?) -> UIAlertController {
        
        let alert = UIAlertController(title: fileTitle, message: fillFieldsConstant, preferredStyle: .alert)
        alert.addTextField { (nameTextField) in
            nameTextField.text = self.emptyConstant
            nameTextField.placeholder = self.enterNameConstant
            nameTextField.tag = self.oneFiledsNameConstant
        }
       
        alert.addAction(UIAlertAction(title: OkConstant, style: .default, handler: { [weak alert] (_) in
            
            var name = String()
            
            for textField in alert!.textFields! {
                if let nameTextField = textField.viewWithTag(self.oneFiledsNameConstant) as? UITextField {
                    name = nameTextField.text!
                }
            }
            
            if type == self.folderType {
                self.presenter.creteNewFolder(name: name, inFolderWithId: self.view.currentFolder.id)
            }
            else if type == self.imageType {
                self.presenter.creteNewImage(name: name, imageData: content as! Data, inFolderWithId: self.view.currentFolder.id)
                
            } else if type == self.videoType {
                self.presenter.creteNewVideo(name: name, playerData: content as! Data, inFolderWithId: self.view.currentFolder.id)
            }
          }))
            
        return alert
        }
    
    func changeNameAlert(model: TypeOfObject) -> UIAlertController {
        let alert = UIAlertController(title: nameTitle, message: fillFieldsConstant, preferredStyle: .alert)
        alert.addTextField { (nameTextField) in
            nameTextField.text = self.emptyConstant
            nameTextField.placeholder = self.enterNameConstant
            nameTextField.tag = self.changeTwoFiledsNameConstant
        }
        
        alert.addAction(UIAlertAction(title: OkConstant, style: .default, handler: { [weak alert] (_) in
            
            var name = String()
            
            for textField in alert!.textFields! {
                if let nameTextField = textField.viewWithTag(self.changeTwoFiledsNameConstant) as? UITextField {
                    name = nameTextField.text!
                }
            }
            self.detailPresenter.setNewName(name: name, model: model)
    }))
        return alert
    }
   
    func changeTextContenteAlert(model: TypeOfObject) -> UIAlertController {
        let alert = UIAlertController(title: editingTitle, message: editingMessage, preferredStyle: .alert)
        alert.addTextField { (nameTextField) in
            nameTextField.text = self.emptyConstant
            nameTextField.placeholder = self.enterNameConstant
            nameTextField.tag = self.changeTwoFiledsContentConstant
        }
        
        alert.addAction(UIAlertAction(title: OkConstant, style: .default, handler: { [weak alert] (_) in
            
            var content = String()
            
            for textField in alert!.textFields! {
                if let contentTextField = textField.viewWithTag(self.changeTwoFiledsContentConstant) as? UITextField {
                    content = contentTextField.text!
                }
            }
            self.detailPresenter.setNewTextContent(name: content, model: model)
        }))
        return alert
    }
}
