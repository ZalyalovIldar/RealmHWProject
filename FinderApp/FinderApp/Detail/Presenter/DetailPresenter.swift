//
//  DetailPresenter.swift
//  FinderApp
//
//  Created by Александр Арсенюк on 26/02/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class DetailPresenter: DetailViewOutputProtocol {
    
    weak var view: DetailViewInputProtocol!
    var playerManager: AVPlayerManagerProtocol!
    var dataManager: OperationsWithDataProtocol!
    var alertManager: AlertManagerProtoclol!
    weak var tableView: TableViewController!
    var imagePicker: ImagePickerForEditingMangaer!
    
    func unarchiveIncomingData(model: TypeOfObject) {
       
        if model.type == "note" {
        
        let text = dataManager.unarchive(object: model.content, with: String())
        view.setIncomingText(text: text)
       }
       else  if model.type == "picture" {
        
        let image = Data(model.content)
        view.setIncomingImage(image: image)

       } else if model.type == "video" {
        let video = Data(model.content)
        playerManager.setPlayer(data: video)
        }
    }
    
    func editContent(model: TypeOfObject) {
        if model.type == "note" {
         view.presentAlert(alert: alertManager.changeTextContenteAlert(model: model))
        }
        else if model.type == "picture" {
             imagePicker.presentImagePicker(.photoLibrary)
            
        }  else if model.type == "video" {
            imagePicker.presentImagePicker(.video)
        }
    }
    
    func editName(model: TypeOfObject) {
        
        view.presentAlert(alert: alertManager.changeNameAlert(model: model))
    }
    
    func setNewName(name: String, model: TypeOfObject) {
        let realm = try! Realm(configuration: .defaultConfiguration)
        try! realm.write {
            model.name = name
        }
     }
    
    func setNewTextContent(name: String, model: TypeOfObject) {
        let realm = try! Realm(configuration: .defaultConfiguration)
        try! realm.write {
             model.content = dataManager.archive(object: name)
        }
        view.setIncomingText(text: name)
    }
  }
