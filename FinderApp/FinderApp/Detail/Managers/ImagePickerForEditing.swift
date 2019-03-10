//
//  ImagePickerForEditing.swift
//  FinderApp
//
//  Created by Александр Арсенюк on 09/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import UIKit
import Photos
import MobileCoreServices
import AVKit
import MediaPlayer
import RealmSwift
import Realm

class ImagePickerForEditingMangaer: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    enum ImageSource {
        case photoLibrary
        case video
    }
    
    var isImage: Bool?
    var detailView: DetailViewController!
    var imagePicker: UIImagePickerController!
    var alertManager: AlertManagerProtoclol!
    var dataManager: OperationsWithData!
    var plyerManager: AVPlayerManager!
    
    
    /// покзать пикер
    ///
    /// - Parameter source: источник инфы(фото или видео)
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
        detailView.present(imagePicker, animated: true, completion: nil)
        
    }
    
    /// спрятать пикер и отправить ифну дальше
    ///
    /// - Parameters:
    ///   - picker: пикер который надо спрятать
    ///   - info: инфа которую получаем из пикера и передаем дальше
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if isImage == true {
            imagePicker.dismiss(animated: true, completion: nil)
            
            guard let selectedImageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
            let selectedImageUrlData = try! Data(contentsOf: selectedImageUrl)
            let selectedImage = UIImage(data: selectedImageUrlData)
            let selectedImageData = dataManager.archive(object: selectedImage!)
            detailView.setIncomingImage(image: selectedImageData)
            let realm = try! Realm(configuration: .defaultConfiguration)
            try! realm.write {
                 detailView.model?.content = selectedImageData
            }
        }
        else {
            
            imagePicker.dismiss(animated: true, completion: nil)
            guard let selectedVideoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL else { return }
            let selectedVideoUrlData = try! Data(contentsOf: selectedVideoUrl)
            let str = selectedVideoUrlData.hashValue
             let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(String(str)+".mp4")
            print(paths)
            try! selectedVideoUrlData.write(to: URL(fileURLWithPath: paths))
           plyerManager.setPlayer(data: selectedVideoUrlData)
            let realm = try! Realm(configuration: .defaultConfiguration)
            try! realm.write {
                detailView.model?.content = selectedVideoUrlData
            }
            
        }
    }
 }
