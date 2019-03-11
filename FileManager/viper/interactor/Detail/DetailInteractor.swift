//
//  DetailInteractor.swift
//  FileManager
//
//  Created by Гузель on 10/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class DetailInteractor: DetailInteractorInput {
    
    var dataManager: DataBaseManagerProtocol!
    
    func saveImage(_ path: String, item: Object) {
        
        dataManager.performTransaction {
            (item as! MediaModel).path = path
        }
        
        dataManager.updateItem(item: item)
    }
    
    func updateItem(item: Object) {
        dataManager.updateItem(item: item)
    }
    
    func performTransaction(transaction: () -> ()) {
        dataManager.performTransaction(transaction: transaction)
    }
}
