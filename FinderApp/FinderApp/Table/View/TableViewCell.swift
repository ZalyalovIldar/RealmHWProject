//
//  TableViewCell.swift
//  FinderApp
//
//  Created by Александр Арсенюк on 26/02/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeOfContent: UILabel!
    @IBOutlet weak var dateOfCreate: UILabel!
  
    /// скофигурировать ячейку
    ///
    /// - Parameters:
    ///   - image: картинка
    ///   - name: имя
    ///   - size: размер контента
    ///   - date: дата моздания
    func configureCell(image: UIImage, name: String, size: String, date: String){
        cellImage.image = image
        nameLabel.text = name
        sizeOfContent.text = size
        dateOfCreate.text = date
    }
    
}
