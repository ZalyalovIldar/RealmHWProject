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
        
        view.presenter = presenter
        interactor.dataManager = dataBase
        presenter.interactor = interactor
    }
}
