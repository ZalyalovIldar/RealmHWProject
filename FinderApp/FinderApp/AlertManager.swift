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
   
    func createAlertWithTwoTextFields() -> UIAlertController {
        let alert = UIAlertController(title: "New Note", message: "Fill all fields", preferredStyle: .alert)
        alert.addTextField { (nameTextField) in
            nameTextField.text = ""
            nameTextField.placeholder = "Enter the name"
        }
        alert.addTextField { (nameTextField) in
            nameTextField.text = ""
            nameTextField.placeholder = "Enter the text"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let nameTextField = alert!.textFields![0]
            let name = nameTextField.text
            let contentTextField = alert!.textFields![1]
            let content = contentTextField.text
            self.presenter.creteNewNote(name: name!, content: content!, inFolderWithId: self.view.currentFolder.id)
        }))
        return alert
    }
    
    func createAlertWithOneTextFields(type: String, content: Any?) -> UIAlertController {
        
        let alert = UIAlertController(title: "New File", message: "Fill all fields", preferredStyle: .alert)
        alert.addTextField { (nameTextField) in
            nameTextField.text = ""
            nameTextField.placeholder = "Enter the name"
        }
       
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let nameTextField = alert!.textFields![0]
            let name = nameTextField.text
            if type == "folder" {
                self.presenter.creteNewFolder(name: name!, inFolderWithId: self.view.currentFolder.id)
            }
            else if type == "image" {
                self.presenter.creteNewImage(name: name!, imageData: content as! Data, inFolderWithId: self.view.currentFolder.id)
                
            } else if type == "video" {
                self.presenter.creteNewVideo(name: name!, playerData: content as! Data, inFolderWithId: self.view.currentFolder.id)
            }
          }))
            
        return alert
        }
    
    func changeNameAlert(model: TypeOfObject) -> UIAlertController {
        let alert = UIAlertController(title: "New name", message: "Fill all fields", preferredStyle: .alert)
        alert.addTextField { (nameTextField) in
            nameTextField.text = ""
            nameTextField.placeholder = "Enter the new name"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let nameTextField = alert!.textFields![0]
            let name = nameTextField.text
            self.detailPresenter.setNewName(name: name!, model: model)
    }))
        return alert
    }
   
    func changeTextContenteAlert(model: TypeOfObject) -> UIAlertController {
        let alert = UIAlertController(title: "Editing note", message: "Put your new note here", preferredStyle: .alert)
        alert.addTextField { (nameTextField) in
            nameTextField.text = ""
            nameTextField.placeholder = "New content"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let nameTextField = alert!.textFields![0]
            let name = nameTextField.text
            self.detailPresenter.setNewTextContent(name: name!, model: model)
        }))
        return alert
    }

}
