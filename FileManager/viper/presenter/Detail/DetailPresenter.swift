//
//  DetailPresenter.swift
//  FileManager
//
//  Created by Гузель on 10/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class DetailPresenter: DetailViewControllerOutput {
   
    var interactor: DetailInteractorInput!
    
    func saveImage(_ path: String, item: Object) {
        interactor.saveImage(path, item: item)
    }

    func updateItem(item: Object) {
        interactor.updateItem(item: item)
    }
    
    func performTransaction(transaction: () -> ()) {
        interactor.performTransaction(transaction: transaction)
    }
}
