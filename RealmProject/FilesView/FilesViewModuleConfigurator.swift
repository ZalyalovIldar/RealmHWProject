//
//  FilesViewModuleConfigurator.swift
//  RealmProject
//
//  Created by Петр on 27/02/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

final class FilesViewModuleConfigurator: NSObject {
    
    @IBOutlet weak var viewController: UIViewController!
    
    override func awakeFromNib() {
     
        configureModule()
    }
    
    private func configureModule() {
    
        guard let view = viewController as? FilesViewController else { fatalError() }
        
        let imagePickerController = UIImagePickerController()
        let presenter = FilesPresenter()
        let interactor = FilesInteractor()
        let router = FilesRouter()
        
        let databaseManager = DatabaseManager()
        let pickerManager = MediaPickerManager()
        
        pickerManager.delegate = router
        pickerManager.imagePicker = imagePickerController
        
        view.filesPresenter = presenter
        
        presenter.view = view
        presenter.filesRouter = router
        presenter.filesInteractor = interactor
        
        interactor.filesPresenter = presenter
        interactor.databaseManager = databaseManager
        
        router.view = view
        router.mediaPickerManager = pickerManager
        router.filesPresenter = presenter
    }
}
