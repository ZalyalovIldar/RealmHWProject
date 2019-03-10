//
//  OperationsWithData.swift
//  FinderApp
//
//  Created by Александр Арсенюк on 02/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation

/// протокол работы с нс арчивером
protocol OperationsWithDataProtocol {
    
    /// архивируем объект в дату Data
    ///
    /// - Parameter object: объект который архивируем
    /// - Returns: получаем Data нашего объекта
    func archive(object: Any) -> Data
    
    /// разархивируем объект
    ///
    /// - Parameters:
    ///   - object: объект который разархивруем
    ///   - type: тип в который разхивируем
    /// - Returns: Вохвразет элемент
    func unarchive<Element>(object: Data, with type: Element ) -> Element
    
}

class OperationsWithData: OperationsWithDataProtocol {
    
    func archive(object: Any) -> Data {
        
        do {
            let archiver = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
            return archiver
        } catch let error {
            print(error)
            return Data()
        }
    }
    
    func unarchive<Element>(object: Data, with type: Element ) -> Element {
      
        do {
            let unarchiver  = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(object as Data)  as? Element
            return unarchiver!
        } catch let error {
            print(error)
            return error as! Element
        }
     }
 }

