//
//  DetailViewController.swift
//  FileManager
//
//  Created by Гузель on 02/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage

class DetailViewController: UIViewController, DetailViewControllerInput, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var mediaImageView: UIImageView?
    @IBOutlet weak var textLabel: UILabel?
    var currentObject: Object!
    var presenter: DetailViewControllerOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initItems()
    }
    
    /// В зависимости от того, в каком мы объекте, вызываем нужный инициализатор
    func initItems() {
        
        if let text = currentObject as? TextFileModel {
            
            initTextLabel(text: text.content)
        }
        if let media = currentObject as? MediaModel {
            
            initTextLabel(text: AllConstants.empty)
            initMedia(media: media)
        }
    }
    
    func initTextLabel(text: String?) {
        textLabel?.text = text
    }
    
    /// Инициализировать медиа файл
    ///
    /// - Parameter media: медиа файл объект
    func initMedia(media: Object) {
        
        self.mediaImageView?.sd_setImage(with: URL(string: (media as! MediaModel).path), completed: nil)
    }
    
    /// Изменение контента объекта
    ///
    /// - Parameter sender: UIBarButtonItem
    @IBAction func editContent(_ sender: UIBarButtonItem) {
        
        if currentObject is TextFileModel {
            
            let alert = UIAlertController(title: AllConstants.editing, message: AllConstants.enterContent, preferredStyle: .alert)
            alert.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder =  AllConstants.content
            }
            
            let textField = alert.textFields?[0]
            let ok = UIAlertAction(title: AllConstants.ok, style: .default) { (action) in
                if textField?.text?.isEmpty == false {
                    self.textLabel?.text = textField?.text
                    self.presenter.performTransaction {
                        (self.currentObject as! TextFileModel).content = (textField?.text)!
                    }
                    self.presenter.updateItem(item: self.currentObject)
                }
            }
            
            alert.addAction(ok)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        if currentObject is MediaModel {
            
            let alert = UIAlertController(title: AllConstants.source, message: nil, preferredStyle: .actionSheet)
            let download = UIAlertAction(title: AllConstants.download, style: .default) { (action) in
                
                let alert = UIAlertController(title: AllConstants.download, message: AllConstants.url, preferredStyle: .alert)
                alert.addTextField { (textField : UITextField!) -> Void in
                    textField.placeholder = AllConstants.urlPlaceholder
                }
                
                let textField = alert.textFields?[0]
                let ok = UIAlertAction(title: AllConstants.ok, style: .default) { (action) in
                    if textField?.text?.isEmpty == false {
                        self.mediaImageView?.sd_setImage(with: URL(string: (textField?.text)!), completed: nil)
                        self.presenter.saveImage((textField?.text)!, item: self.currentObject)
                    }
                }

                alert.addAction(ok)

                self.present(alert, animated: true, completion: nil)
                
            }
            
            let photoLibAction = UIAlertAction(title: AllConstants.photo, style: .default) { (action) in
                self.chooseImagePickerAction(source: .photoLibrary)
            }
            
            let cancel = UIAlertAction(title: AllConstants.cancel, style: .cancel, handler: nil)
            alert.addAction(download)
            alert.addAction(photoLibAction)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //Методы для получения картинки из галереи
    
    func chooseImagePickerAction(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
        
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.mediaImageView?.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        mediaImageView?.contentMode = .scaleAspectFill
        mediaImageView?.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
}
