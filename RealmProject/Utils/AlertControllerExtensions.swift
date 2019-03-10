//
//  AlertControllerExtensions.swift
//  RealmProject
//
//  Created by Петр on 10/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    func addImage(image: UIImage) {
        
        let maxSize = CGSize(width: 245, height: 300)
        let imageSize = image.size
        
        let ratio: CGFloat!
        
        if imageSize.width > imageSize.height {
            ratio = maxSize.width / imageSize.width
        }
        else {
            ratio = maxSize.height / imageSize.height
        }
        
        let scaledSize = CGSize(width: imageSize.width * ratio, height: imageSize.height * ratio)
        
        let imageAction = UIAlertAction(title: "", style: .default, handler: nil)
        imageAction.isEnabled = true
        imageAction.setValue(ResizeImage(image: image, targetSize: scaledSize).withRenderingMode(.alwaysOriginal), forKey: "image")
        self.addAction(imageAction)
    }
    
    private func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
