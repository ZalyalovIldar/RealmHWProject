//
//  TextFileModel.swift
//  FileManager
//
//  Created by Гузель on 02/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class TextFileModel: Object {
    
    dynamic var id = 0
    dynamic var name = String()
    dynamic var time = Date()
    dynamic var content = String()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
