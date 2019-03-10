//
//  Classes.swift
//  FinderApp
//
//  Created by Александр Арсенюк on 28/02/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Realm

@objcMembers

class TypeOfObject: Object {
    dynamic var id = String()
    dynamic var name = String()
    dynamic var content = Data()
    dynamic var picture = Data()
    dynamic var type = String()
    dynamic var dateOfCreate = Date()
    dynamic var folderId = String()
}

@objcMembers
class Folder: Object {
    dynamic var id = String()
    dynamic var name = String()
    dynamic var content = List<TypeOfObject>()
    dynamic var picture = Data()
    dynamic var dateOfCreate = Date()
    dynamic var type = String()
}
