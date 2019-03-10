//
//  DetailConfigurator.swift
//  FinderApp
//
//  Created by Александр Арсенюк on 26/02/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import UIKit

class DetailConfigurator: NSObject {
    
    @IBOutlet weak var viewController: UIViewController!
    
    override func awakeFromNib() {
        
        configureModule()
    }
    
    /// сконфигурировать контроллер
    func configureModule() {
        
        guard let view = viewController as? DetailViewController else { fatalError() }
        
        let playerManager = AVPlayerManager()
        let preseneter = DetailPresenter()
        let dataManager = OperationsWithData()
        let alertManager = AlertManager()
        let imagePicker = ImagePickerForEditingMangaer()
        
        alertManager.detailPresenter = preseneter
        
        imagePicker.alertManager = alertManager
        imagePicker.dataManager = dataManager
        imagePicker.detailView  = view
        imagePicker.plyerManager = playerManager
        
        preseneter.view = view
        preseneter.playerManager = playerManager
        preseneter.dataManager = dataManager
        preseneter.alertManager = alertManager
        preseneter.imagePicker = imagePicker
        
        view.presenter = preseneter
        view.dataManger = dataManager
        
        
        playerManager.detailViewController = view
        playerManager.dataManager = dataManager
        
    }
}
