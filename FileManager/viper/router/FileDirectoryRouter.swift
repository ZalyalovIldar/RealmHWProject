//
//  FileDirectoryRouter.swift
//  FileManager
//
//  Created by Гузель on 02/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class FileDirectoryRouter: FileDirectoryRouterInput {
    
    /// экземпляр ViewController
    weak var view: UIViewController!
    var presenter: FileDirectoryRouterOutput!
    /// alert
    let alert = "Alert"
    /// message alert
    let message = "New Item"
    /// folder alert
    let folder = "Folder"
    /// text alert
    let text = "New Text File"
    /// image alert
    let image = "New Image"
    /// video alert
    let video = "New Video"
    /// textField alert placeholder
    let placeholder = "Add Name Of Item"
    /// название сториборда
    let main = "Main"
    let mySelf = "self"
    let detail = "detail"
    
    func showAlert(item: FolderModel) {
        
        let alert = UIAlertController(title: self.alert, message: message, preferredStyle: .alert)
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = self.placeholder
        }
        let textField = alert.textFields?[0]
        let folder = UIAlertAction(title: self.folder, style: .default) { (action) in
            self.presenter.addNewItem(item: item, name: textField?.text ?? self.folder, type: (Type.folder).rawValue)
        }
        let text = UIAlertAction(title: self.text, style: .default) { (action) in
            self.presenter.addNewItem(item: item, name: textField?.text ?? self.text, type: (Type.text).rawValue)
        }
        let image = UIAlertAction(title: self.image, style: .default) { (action) in
            self.presenter.addNewItem(item: item, name: textField?.text ?? self.image, type: (Type.image).rawValue)
        }
        let video = UIAlertAction(title: self.video, style: .default) { (action) in
            self.presenter.addNewItem(item: item, name: textField?.text ?? self.video, type: (Type.video).rawValue)
        }
        alert.addAction(folder)
        alert.addAction(text)
        alert.addAction(image)
        alert.addAction(video)
        
        view.present(alert, animated: true, completion: nil)
    }
    
    func showEditNameAlert(_ item: Object, _ folder: FolderModel) {
        
        let alert = UIAlertController(title: "Editing", message: "Edit name of Item", preferredStyle: .alert)
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "New name"
        }
        let textField = alert.textFields?[0]
        let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.presenter.editNameOfObject(item, folder, textField?.text)
        }
        
        alert.addAction(ok)
        
        view.present(alert, animated: true, completion: nil)
    }
    
    func showFolder(item: FolderModel) {
        
        let mainStoryboard = UIStoryboard(name: main, bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: mySelf) as! MainTableViewController
        
        vc.initItem(item: item)
        view.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showText(item: TextFileModel) {
        let mainStoryboard = UIStoryboard(name: main, bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: detail) as! DetailViewController
        
        vc.currentObject = item
        view.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showMedia(item: MediaModel) {
        let mainStoryboard = UIStoryboard(name: main, bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: detail) as! DetailViewController
        
        vc.currentObject = item
        view.navigationController?.pushViewController(vc, animated: true)
    }
}
