//
//  DetailViewControllerInput.swift
//  FileManager
//
//  Created by Гузель on 02/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation

protocol DetailViewControllerInput: AnyObject {
    
    /// Инициализировать содержимое текст файла
    ///
    /// - Parameter text: контент
    func initTextLabel(text: String?)
}
