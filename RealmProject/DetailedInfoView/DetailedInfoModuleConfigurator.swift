//
//  DetailedInfoModuleConfigurator.swift
//  RealmProject
//
//  Created by Петр on 08/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import UIKit

class DetailedInfoModuleConfigurator: NSObject {
    
    @IBOutlet weak var viewController: UIViewController!
    
    override func awakeFromNib() {
        
        configureModule()
    }
    
    private func configureModule() {
        
        guard let view = viewController as? DetailedInfoViewController else { fatalError() }
        
        let imagePickerController = UIImagePickerController()
        let presenter = DetailedInfoPresenter()
        let interactor = DetailedInfoInteractor()
        let router = DetailedInfoRouter()
        
        let databaseManager = DatabaseManager()
        let networkManager = NetworkManager()
        let pickerManager = MediaPickerManager()
        
        pickerManager.delegate = router
        pickerManager.imagePicker = imagePickerController
        
        view.detailedInfoPresenter = presenter
        
        presenter.view = view
        presenter.detailedInfoRouter = router
        presenter.detailedInfoInteractor = interactor
        
        interactor.detailedInfoPresenter = presenter
        interactor.databaseManager = databaseManager
        interactor.networkManager = networkManager
        
        router.view = view
        router.mediaPickerManager = pickerManager
        router.detailedInfoPresenter = presenter
    }
}
