//
//  Photo.swift
//  RealmProject
//
//  Created by Петр on 03/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Photo: Object{
    
    dynamic var id = String(describing: UUID.init())
    dynamic var title = String()
    dynamic var dateOfCreation = Date()
    dynamic var imageData = Data()
    dynamic var imageUrl: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
