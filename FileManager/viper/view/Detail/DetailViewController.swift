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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initItems()
    }
    
    /// В зависимости от того, в каком мы объекте, вызываем нужный инициализатор
    func initItems() {
        
        if let text = currentObject as? TextFileModel {
            
            initTextLabel(text: text.content)
        }
        if let media = currentObject as? MediaModel {
            
            initTextLabel(text: AllConstants.empty.rawValue)
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
        
        if let _ = currentObject as? TextFileModel {
            
            let alert = UIAlertController(title: AllConstants.editing.rawValue, message: AllConstants.enterContent.rawValue, preferredStyle: .alert)
            alert.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder =  AllConstants.content.rawValue
            }
            
            let textField = alert.textFields?[0]
            let ok = UIAlertAction(title: AllConstants.ok.rawValue, style: .default) { (action) in
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
        
        if let _ = currentObject as? MediaModel {
            
            let alert = UIAlertController(title: AllConstants.source.rawValue, message: nil, preferredStyle: .actionSheet)
            let download = UIAlertAction(title: AllConstants.download.rawValue, style: .default) { (action) in
                
                let alert = UIAlertController(title: AllConstants.download.rawValue, message: AllConstants.url.rawValue, preferredStyle: .alert)
                alert.addTextField { (textField : UITextField!) -> Void in
                    textField.placeholder = AllConstants.urlPlaceholder.rawValue
                }
                
                let textField = alert.textFields?[0]
                let ok = UIAlertAction(title: AllConstants.ok.rawValue, style: .default) { (action) in
                    if textField?.text?.isEmpty == false {
                        self.mediaImageView?.sd_setImage(with: URL(string: (textField?.text)!), completed: nil)
                        self.presenter.saveImage((textField?.text)!, item: self.currentObject)
                    }
                }

                alert.addAction(ok)

                self.present(alert, animated: true, completion: nil)
                
            }
            
            let photoLibAction = UIAlertAction(title: AllConstants.photo.rawValue, style: .default) { (action) in
                self.chooseImagePickerAction(source: .photoLibrary)
            }
            
            let cancel = UIAlertAction(title: AllConstants.cancel.rawValue, style: .cancel, handler: nil)
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
