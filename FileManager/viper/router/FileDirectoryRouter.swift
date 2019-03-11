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

enum AllConstants: String {
    
    case alert = "Alert",
    message = "New Item",
    folder = "Folder",
    text = "New Text File",
    image = "New Image",
    video = "New Video",
    placeholder = "Add Name Of Item",
    main = "Main",
    mySelf = "self",
    detail = "detail",
    editing = "Editing",
    editNameOfItem = "Edit name of Item",
    newName = "New name",
    ok = "Ok",
    fileDirectory = "FileDirectory",
    defaultName = "Default",
    empty = "",
    format = "%.3f",
    cell = "Cell",
    dateFormetter = "yyyy-MM-dd",
    kb = "KБ",
    delete = "Delete",
    enterContent = "Enter the content of TextFile",
    content = "content",
    cancel = "Cancel",
    photo = "Photo",
    download = "Download",
    urlPlaceholder = "url",
    url = "Enter url of image",
    source = "Source Of Photo"
}

class FileDirectoryRouter: FileDirectoryRouterInput {
    
    /// экземпляр ViewController
    weak var view: UIViewController!
    var presenter: FileDirectoryRouterOutput!
    
    func showAlert(item: FolderModel) {
        
        let alert = UIAlertController(title: AllConstants.alert.rawValue, message: AllConstants.message.rawValue, preferredStyle: .alert)
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = AllConstants.placeholder.rawValue
        }
        
        let textField = alert.textFields?[0]
        
        let folder = UIAlertAction(title: AllConstants.folder.rawValue, style: .default) { (action) in
            self.presenter.addNewItem(item: item, name: textField?.text ?? AllConstants.folder.rawValue, type: (Type.folder).rawValue)
        }
        
        let text = UIAlertAction(title: AllConstants.text.rawValue, style: .default) { (action) in
            self.presenter.addNewItem(item: item, name: textField?.text ?? AllConstants.text.rawValue, type: (Type.text).rawValue)
        }
        
        let image = UIAlertAction(title: AllConstants.image.rawValue, style: .default) { (action) in
            self.presenter.addNewItem(item: item, name: textField?.text ?? AllConstants.image.rawValue, type: (Type.image).rawValue)
        }
        
        let video = UIAlertAction(title: AllConstants.video.rawValue, style: .default) { (action) in
            self.presenter.addNewItem(item: item, name: textField?.text ?? AllConstants.video.rawValue, type: (Type.video).rawValue)
        }
        
        alert.addAction(folder)
        alert.addAction(text)
        alert.addAction(image)
        alert.addAction(video)
        
        view.present(alert, animated: true, completion: nil)
    }
    
    func showEditNameAlert(_ item: Object, _ folder: FolderModel) {
        
        let alert = UIAlertController(title: AllConstants.editing.rawValue, message: AllConstants.editNameOfItem.rawValue, preferredStyle: .alert)
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = AllConstants.newName.rawValue
        }
        
        let textField = alert.textFields?[0]
        let ok = UIAlertAction(title: AllConstants.ok.rawValue, style: .default) { (action) in
            self.presenter.editNameOfObject(item, folder, textField?.text)
        }
        
        alert.addAction(ok)
        
        view.present(alert, animated: true, completion: nil)
    }
    
    func showFolder(item: FolderModel) {
        
        let mainStoryboard = UIStoryboard(name: AllConstants.main.rawValue, bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: AllConstants.mySelf.rawValue) as! MainTableViewController
        
        vc.initItem(item: item)
        view.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showText(item: TextFileModel) {
        
        let mainStoryboard = UIStoryboard(name: AllConstants.main.rawValue, bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: AllConstants.detail.rawValue) as! DetailViewController
        
        vc.currentObject = item
        view.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showMedia(item: MediaModel) {
        
        let mainStoryboard = UIStoryboard(name: AllConstants.main.rawValue, bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: AllConstants.detail.rawValue) as! DetailViewController
        
        vc.currentObject = item
        view.navigationController?.pushViewController(vc, animated: true)
    }
}
