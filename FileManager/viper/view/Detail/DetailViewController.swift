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

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initItems()
    }
    
    func initItems() {
        
        if let text = currentObject as? TextFileModel {
            
            initTextLabel(text: text.content)
        }
        if let media = currentObject as? MediaModel {
            
            initTextLabel(text: "")
            initMedia(media: media)
        }
    }
    
    func initTextLabel(text: String?) {
        textLabel?.text = text
    }
    
    func initMedia(media: Object) {
        
        self.mediaImageView?.sd_setImage(with: URL(string: (media as! MediaModel).path), completed: nil)
    }
    
    @IBAction func editContent(_ sender: UIBarButtonItem) {
        
        if let _ = currentObject as? TextFileModel {
            
            let alert = UIAlertController(title: "Etiting", message: "Enter the content of TextFile", preferredStyle: .alert)
            alert.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "content"
            }
            let textField = alert.textFields?[0]
            let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
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
            
            let alert = UIAlertController(title: "Источник фотографий", message: nil, preferredStyle: .actionSheet)
            let download = UIAlertAction(title: "Скачать", style: .default) { (action) in
                
                let alert = UIAlertController(title: "Download", message: "Enter url of image", preferredStyle: .alert)
                alert.addTextField { (textField : UITextField!) -> Void in
                    textField.placeholder = "url"
                }
                let textField = alert.textFields?[0]
                let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
                    if textField?.text?.isEmpty == false {
                        self.mediaImageView?.sd_setImage(with: URL(string: (textField?.text)!), completed: nil)
                        self.presenter.saveImage((textField?.text)!, item: self.currentObject)
                    }
                }

                alert.addAction(ok)

                self.present(alert, animated: true, completion: nil)
                
            }
            let photoLibAction = UIAlertAction(title: "Фото", style: .default) { (action) in
                self.chooseImagePickerAction(source: .photoLibrary)
            }
            let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alert.addAction(download)
            alert.addAction(photoLibAction)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
