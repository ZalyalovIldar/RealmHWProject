//
//  FileTableViewCell.swift
//  RealmProject
//
//  Created by Петр on 27/02/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import UIKit
import RealmSwift

class FilesTableViewCell: UITableViewCell {

    /// Icon image
    @IBOutlet weak var iconImageView: UIImageView!

    /// Title of file
    @IBOutlet weak var titleLabel: UILabel!
    
    /// Date of creation
    @IBOutlet weak var dateOfCreationLabel: UILabel!
    
    /// Size of file
    @IBOutlet weak var sizeLabel: UILabel!
       
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(object: Object) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "en_US")
        
        if let folder = object as? Folder {
            
            titleLabel.text = folder.title
            dateOfCreationLabel.text = dateFormatter.string(from: folder.dateOfCreation)
            iconImageView.image = UIImage(named: ImagePath.Folder.rawValue)
        }
        else if let photo = object as? Photo {
            
            titleLabel.text = photo.title
            dateOfCreationLabel.text = dateFormatter.string(from: photo.dateOfCreation)
            iconImageView.image = UIImage(named: ImagePath.Photo.rawValue)
        }
        else if let video = object as? Video {
            
            titleLabel.text = video.title
            dateOfCreationLabel.text = dateFormatter.string(from: video.dateOfCreation)
            iconImageView.image = UIImage(named: ImagePath.Video.rawValue)
        }
        else if let note = object as? Note {
            
            titleLabel.text = note.title
            dateOfCreationLabel.text = dateFormatter.string(from: note.dateOfCreation)
            iconImageView.image = UIImage(named: ImagePath.Note.rawValue)
        }
    }

}
