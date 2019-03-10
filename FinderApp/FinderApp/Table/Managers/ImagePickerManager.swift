//
//  ImagePickerManager.swift
//  FinderApp
//
//  Created by Александр Арсенюк on 03/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import UIKit
import Photos
import MobileCoreServices
import AVKit
import MediaPlayer


class ImagePickerMangaer: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    enum ImageSource {
        case photoLibrary
        case video
    }
    
    var isImage: Bool?
    var tableView: TableViewController!
    var imagePicker: UIImagePickerController!
    var alertManager: AlertManagerProtoclol!
    var dataManager: OperationsWithData!
  
    ///   показать имадж пикео
    ///
    /// - Parameter source: источник дданных (фотки или видосы)
    func presentImagePicker(_ source: ImageSource) {
        
        imagePicker = UIImagePickerController()
        
        switch source {
        case .photoLibrary :
            imagePicker.sourceType = .photoLibrary
            isImage = true
        case .video:
            imagePicker.sourceType = .photoLibrary
            isImage = false
            imagePicker.mediaTypes = [kUTTypeMovie as String]
        }
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        tableView.present(imagePicker, animated: true, completion: nil)
        
    }
    
    /// закрыть пикер и передать инфу дальше
    ///
    /// - Parameters:
    ///   - picker: закрываемый пикер
    ///   - info: полученная инфа из пикера
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if isImage == true {
            imagePicker.dismiss(animated: true, completion: nil)
            guard let selectedImageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else {
                return
        }
            let selectedImageUrlData = try! Data(contentsOf: selectedImageUrl)
            let selectedImage = UIImage(data: selectedImageUrlData)
            let selectedImageData = dataManager.archive(object: selectedImage!)
            tableView.present(alertManager.createAlertWithOneTextFields(type: "image", content: selectedImageData ), animated: true, completion: nil)
        }
        else {
            imagePicker.dismiss(animated: true, completion: nil)
            guard let selectedVideoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL else {
                return
            }
            let selectedVideoUrlData = try! Data(contentsOf: selectedVideoUrl)
            let str = selectedVideoUrlData.hashValue
            let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(String(str)+".mp4")
           try! selectedVideoUrlData.write(to: URL(fileURLWithPath: paths))
           tableView.present(alertManager.createAlertWithOneTextFields(type: "video", content: selectedVideoUrlData ), animated: true, completion: nil)
        }
    }
}
