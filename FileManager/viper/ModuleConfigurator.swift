//
//  ModuleConfigurator.swift
//  FileManager
//
//  Created by Гузель on 08/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import UIKit

class ModuleConfigurator: NSObject {
    
    @IBOutlet weak var vc: UITableViewController!
    
    override func awakeFromNib() {
        configureModule()
    }
    
    func configureModule() {
        
        guard let view = vc as? MainTableViewController else { fatalError() }
        
        let dataBase = DataBaseManager()
        let presenter = FileDirectoryPresenter()
        let interactor = FileDirectoryInteractor()
        let router = FileDirectoryRouter()
        
        view.presenter = presenter
        interactor.dataManager = dataBase
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        router.view = view
        router.presenter = presenter
    }
}
