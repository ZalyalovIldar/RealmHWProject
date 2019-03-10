//
//  TableModuleConfigurator.swift
//  FinderApp
//
//  Created by Александр Арсенюк on 02/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import UIKit

class TableModuleConfigurator: NSObject {
    
    @IBOutlet weak var viewController: UIViewController!
    
    override func awakeFromNib() {
        
        configureModule()
    }
    
    /// сконфигурировать контроллер
    func configureModule() {
        
        guard let view = viewController as? TableViewController else { fatalError() }
        
        let presenter = TablePresenter()
        let dbManager = DataBaseManager()
        let dataManager = OperationsWithData()
        let alertManager = AlertManager()
        let imagePicker = ImagePickerMangaer()
        
        
        
        view.dataManager = dataManager
        view.dbManager = dbManager
        view.presenter = presenter
       
        
       
        presenter.dataManager = dataManager
        presenter.dbManager = dbManager
        presenter.view = view
        presenter.imagePicker = imagePicker
        presenter.tableViewController = view
        presenter.alertManager = alertManager
        
        alertManager.presenter = presenter
        alertManager.view = view
        
        imagePicker.tableView = view
        imagePicker.alertManager = alertManager
        imagePicker.dataManager = dataManager
       
    }
}
