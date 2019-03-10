//
//  DetailModuleConfigurations.swift
//  FileManager
//
//  Created by Гузель on 10/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import UIKit

class DetailModuleConfigurations: NSObject {
    
    @IBOutlet weak var vc: UIViewController!
    
    override func awakeFromNib() {
        configureModule()
    }
    
    func configureModule() {
        
        guard let view = vc as? DetailViewController else { fatalError() }
        
        let dataBase = DataBaseManager()
        let presenter = DetailPresenter()
        let interactor = DetailInteractor()
//        let router = DetailRouter()
        
        view.presenter = presenter
        interactor.dataManager = dataBase
//        interactor.presenter = presenter
        presenter.interactor = interactor
//        presenter.router = router
//        presenter.view = view
//        router.view = view
//        router.presenter = presenter
    }
}
