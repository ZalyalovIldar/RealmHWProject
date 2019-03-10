//
//  DetailViewControllerOutput.swift
//  FileManager
//
//  Created by Гузель on 02/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

protocol DetailViewControllerOutput: AnyObject {
    
    func saveImage(_ path: String, item: Object)
    
    func updateItem(item: Object)
    
    func performTransaction(transaction: () -> ())
}
