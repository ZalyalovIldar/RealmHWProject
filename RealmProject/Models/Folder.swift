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
    dynamic var folders = List<Folder>()
    dynamic var notes = List<Note>()
    dynamic var photos = List<Photo>()
    dynamic var videos = List<Video>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
