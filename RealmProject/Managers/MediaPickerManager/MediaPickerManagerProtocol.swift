//
//  MediaPickerManagerProtocol.swift
//  RealmProject
//
//  Created by Петр on 07/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import UIKit

protocol MediaPickerManagerProtocol {
    
    var delegate: MediaPickerDelegate? { get set }
    
    func showImagePicker(in view: UIViewController, type: MediaType)
    
}
