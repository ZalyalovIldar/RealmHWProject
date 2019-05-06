//
//  Folder.swift
//  RealmProject
//
//  Created by Петр on 01/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class Folder: Object {
    
    dynamic var id = String(describing: UUID.init())
    dynamic var title = String()
    dynamic var isRootFolder = false
    dynamic var dateOfCreation = Date()
    var folders = List<Folder>()
    var notes = List<Note>()
    var photos = List<Photo>()
    var videos = List<Video>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
