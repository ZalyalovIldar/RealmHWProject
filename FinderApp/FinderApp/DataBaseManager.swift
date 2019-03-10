//
//  DataBaseManager.swift
//  FinderApp
//
//  Created by Александр Арсенюк on 01/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

/// протокол работы с датой
protocol DataBaseManagerProtocol {
    
    /// сохраняет модель в бд
    ///
    /// - Parameter model: сохраняемая модель
    func save(model: TypeOfObject)
    
    /// получить все модели из бд
    ///
    /// - Returns: массив из всех моделей
    func obtainModels() -> [TypeOfObject]
    
    /// удаляет заднную модель из бд
    ///
    /// - Parameter model: удаляемая модель
    func removeModel(model: TypeOfObject)
    
    /// удаляет все из бд
    ///
    func clearAll()
    
    /// получаем массив объектов у которых номер папки равен заданному
    ///
    /// - Parameter id: номер папки,у которой мы получаем объекты
    /// - Returns: массив объектов внутри папки с заданным  id
    func obtaimModelsWithId(id: String) -> [TypeOfObject]
}

class DataBaseManager: DataBaseManagerProtocol {
    
    fileprivate lazy var mainRealm: Realm = {
        // Inside your application(application:didFinishLaunchingWithOptions:)
        
        let config = Realm.Configuration(
            
            schemaVersion: 4,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 4) {
                  
                }
        })
        Realm.Configuration.defaultConfiguration = config
        return try! Realm(configuration: .defaultConfiguration)
    }()
    
    func save(model: TypeOfObject) {
        
        try! mainRealm.write {
             mainRealm.add(model)
        }
    }
    
    func obtainModels() -> [TypeOfObject] {
        
        let models = mainRealm.objects(TypeOfObject.self)
         return Array(models)
    }
    
    func obtaimModelsWithId(id: String) -> [TypeOfObject] {
    
        let models = obtainModels()
        var result: [TypeOfObject] = []
        for model in models{
            if model.folderId == id {
                result.append(model)
            }
        }
        return result
    }
    
    func removeModel(model: TypeOfObject) {
        
        if model.type == "folder" {
            let allModels = obtainModels()
            for oneOfModel in allModels {
                if oneOfModel.folderId == model.id {
                try! mainRealm.write {
                    mainRealm.delete(oneOfModel)
                    }
                }
            }
            try! mainRealm.write {
                mainRealm.delete(model)
            }
        }
        else {
        try! mainRealm.write {
                mainRealm.delete(model)
          }
        }
}
    
    
    func clearAll() {
        
        try! mainRealm.write {
            mainRealm.deleteAll()
        }
    }
    
    
   
}
