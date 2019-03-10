//
//  FolderModel.swift
//  FileManager
//
//  Created by Гузель on 02/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

@objcMembers
class FolderModel: Object {
    
    dynamic var id = 0
    dynamic var name = String()
    dynamic var time = Date()
    var folders: List<FolderModel>? = List<FolderModel>()
    var textFiles: List<TextFileModel>? = List<TextFileModel>()
    var media: List<MediaModel>? = List<MediaModel>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
