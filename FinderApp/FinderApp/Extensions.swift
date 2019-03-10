//
//  Extensions.swift
//  FinderApp
//
//  Created by Александр Арсенюк on 04/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation



extension Data {
    
    /// описывает дату в привычных единицах ихмерения байты, килобайты, мегабайты
    ///
    /// - Returns: размер объекта
    func discribe() -> String {
        let strWithoutWordBytes = self.description.dropLast(6)
        let strToInt = Int(strWithoutWordBytes)
        if strToInt! > 1024 && strToInt! < 1048576 {
            let newStr = String(strToInt!/1000)
            return (newStr+" "+"Kb")
        }
        else if strToInt! > 1048576 {
            let newStr = String(strToInt!/1000000)
            return (newStr+" "+"Mb")
        }
        else {
            let newStr = String(strToInt!)
            return (newStr+" "+"b")
            
        }
    }
}


