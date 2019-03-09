//
//  File.swift
//  RealmProject
//
//  Created by Петр on 01/03/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Note: Object{

    dynamic var id = String(describing: UUID.init())
    dynamic var title = String()
    dynamic var dateOfCreation = Date()
    dynamic var text = String()

    override static func primaryKey() -> String? {
        return "id"
    }
}
