//
//  Constants.swift
//  RealmProject
//
//  Created by Петр on 28/02/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import Foundation

enum Identifires: String {
    
    case Cell = "cell"
    case DetailedInfoViewController = "detailedInfoVC"
    case FilesViewController = "filesVC"
}

enum Segues: String {
    case Detail = "detailed"
    case Inside = "inside"
}

enum MediaType {
    case Photo
    case Video
    case Note
}

enum ImagePath: String {
    
    case Folder = "folder"
    case Photo = "picture"
    case Video = "video"
    case Note = "edit"
}

enum AlertTitles: String {
    
    case Cancel = "Cancel"
    case Next = "Next"
    case AlertTitle = "Fill the fields"
    case TextPlaceholder = "Text"
    case TitlePlaceholder = "Title"
}

let rootFolderTitle = "Files"
