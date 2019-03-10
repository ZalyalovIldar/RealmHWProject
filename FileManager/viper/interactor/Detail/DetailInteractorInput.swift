//
//  DetailInteractorInput.swift
//  FileManager
//
//  Created by Гузель on 10/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

protocol DetailInteractorInput: AnyObject {
    
    func saveImage(_ path: String, item: Object)
    
    func updateItem(item: Object) 
    
    func performTransaction(transaction: () -> ())
}
