//
//  MediaPickerManager.swift
//  RealmProject
//
//  Created by Петр on 06/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import UIKit

class MediaPickerManager:
    NSObject,
    MediaPickerManagerProtocol,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {
    
    var delegate: MediaPickerDelegate?
    
    var mediaType: MediaType?
    
    var imagePicker: UIImagePickerController!
    
    
    func showImagePicker(view: UIViewController, type: MediaType) {
        
        self.mediaType = type
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = ["public.image", "public.movie"]
        
        view.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let type = self.mediaType else { return }

        switch type {
            
        case .Photo:
            if let editedImage = info[.editedImage] as? UIImage {
                delegate?.handleSelectedImage(imageData: editedImage.pngData())
            }
            break
            
        case.Video:
            if let videoUrl = info[.mediaURL] as? URL {
                delegate?.handleSelectedVideo(videoUrlPath: videoUrl)
            }
            break
            
        default:
            break
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
