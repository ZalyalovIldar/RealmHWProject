//
//  DetailViewInput.swift
//  FinderApp
//
//  Created by Александр Арсенюк on 26/02/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import UIKit

protocol DetailViewInputProtocol: AnyObject {
    
    /// показать картинку
    ///
    /// - Parameter image: картинрка
    func setIncomingImage(image: Data)
    
    /// установить новый текст
    ///
    /// - Parameter text: текст
    func setIncomingText(text: String)
    
    /// установить новый видос
    ///
    /// - Parameter video: видео
    func setIncomingVideo(video: Data)
    
    /// покзать алерт
    ///
    /// - Parameter alert: алерт
    func presentAlert(alert: UIAlertController)
    
}
