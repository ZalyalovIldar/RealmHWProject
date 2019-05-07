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

enum AllConstants {
    
    static let alert = "Alert"
    static let message = "New Item"
    static let folder = "Folder"
    static let text = "New Text File"
    static let image = "New Image"
    static let video = "New Video"
    static let placeholder = "Add Name Of Item"
    static let main = "Main"
    static let mySelf = "self"
    static let detail = "detail"
    static let editing = "Editing"
    static let editNameOfItem = "Edit name of Item"
    static let newName = "New name"
    static let ok = "OK"
    static let fileDirectory = "FileDirectory"
    static let defaultName = "Default"
    static let empty = ""
    static let format = "%.3f"
    static let cell = "Cell"
    static let dateFormetter = "yyyy-MM-dd"
    static let kb = "KБ"
    static let delete = "Delete"
    static let enterContent = "Enter the content of TextFile"
    static let content = "content"
    static let cancel = "Cancel"
    static let photo = "Photo"
    static let download = "Download"
    static let urlPlaceholder = "url"
    static let url = "Enter url of image"
    static let source = "Source Of Photo"
}

class FileDirectoryRouter: FileDirectoryRouterInput {
    
    /// экземпляр ViewController
    weak var view: UIViewController!
    var presenter: FileDirectoryRouterOutput!
    
    func showAlert(item: FolderModel) {
        
        let alert = UIAlertController(title: AllConstants.alert, message: AllConstants.message, preferredStyle: .alert)
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = AllConstants.placeholder
        }
        
        let textField = alert.textFields?[0]
        
        let folder = UIAlertAction(title: AllConstants.folder, style: .default) { (action) in
            self.presenter.addNewItem(item: item, name: textField?.text ?? AllConstants.folder, type: Type.folder)
        }
        
        let text = UIAlertAction(title: AllConstants.text, style: .default) { (action) in
            self.presenter.addNewItem(item: item, name: textField?.text ?? AllConstants.text, type: Type.text)
        }
        
        let image = UIAlertAction(title: AllConstants.image, style: .default) { (action) in
            self.presenter.addNewItem(item: item, name: textField?.text ?? AllConstants.image, type: Type.image)
        }
        
        let video = UIAlertAction(title: AllConstants.video, style: .default) { (action) in
            self.presenter.addNewItem(item: item, name: textField?.text ?? AllConstants.video, type: Type.video)
        }
        
        alert.addAction(folder)
        alert.addAction(text)
        alert.addAction(image)
        alert.addAction(video)
        
        view.present(alert, animated: true, completion: nil)
    }
    
    func showEditNameAlert(_ item: Object, _ folder: FolderModel) {
        
        let alert = UIAlertController(title: AllConstants.editing, message: AllConstants.editNameOfItem, preferredStyle: .alert)
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = AllConstants.newName
        }
        
        let textField = alert.textFields?[0]
        let ok = UIAlertAction(title: AllConstants.ok, style: .default) { (action) in
            self.presenter.editNameOfObject(item, folder, textField?.text)
        }
        
        alert.addAction(ok)
        
        view.present(alert, animated: true, completion: nil)
    }
    
    func showFolder(item: FolderModel) {
        
        let mainStoryboard = UIStoryboard(name: AllConstants.main, bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: AllConstants.mySelf) as! MainTableViewController
        
        vc.initItem(item: item)
        view.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showText(item: TextFileModel) {
        
        let mainStoryboard = UIStoryboard(name: AllConstants.main, bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: AllConstants.detail) as! DetailViewController
        
        vc.currentObject = item
        view.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showMedia(item: MediaModel) {
        
        let mainStoryboard = UIStoryboard(name: AllConstants.main, bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: AllConstants.detail) as! DetailViewController
        
        vc.currentObject = item
        view.navigationController?.pushViewController(vc, animated: true)
    }
}
