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
        createVideosDirectory()
    }
    
    private func configureModule() {
    
        guard let view = viewController as? FilesViewController else { fatalError() }
        
        let imagePickerController = UIImagePickerController()
        let presenter = FilesPresenter()
        let interactor = FilesInteractor()
        let router = FilesRouter()
        
        let databaseManager = DatabaseManager()
        let networkManager = NetworkManager()
        let pickerManager = MediaPickerManager()
        
        pickerManager.delegate = router
        pickerManager.imagePicker = imagePickerController
        
        view.filesPresenter = presenter
        
        presenter.view = view
        presenter.filesRouter = router
        presenter.filesInteractor = interactor
        
        interactor.filesPresenter = presenter
        interactor.networkManager = networkManager
        interactor.databaseManager = databaseManager
        
        router.view = view
        router.mediaPickerManager = pickerManager
        router.filesPresenter = presenter
    }
    
    private func createVideosDirectory() {
    
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: videoDirectoryPath) {
            
            do {
                try fileManager.createDirectory(atPath: videoDirectoryPath, withIntermediateDirectories: true, attributes: nil)
            }
            catch (let error){
                print("Error during directory creating: \(error)")
            }
        }
        
    
    }
}
